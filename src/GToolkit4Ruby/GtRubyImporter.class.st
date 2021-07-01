Class {
	#name : #GtRubyImporter,
	#superclass : #Object,
	#traits : 'TRubyProgramNodeVisitor',
	#classTraits : 'TRubyProgramNodeVisitor classTrait',
	#instVars : [
		'mooseModel',
		'scopeStack',
		'currentFile',
		'files',
		'folders',
		'classesAndModules'
	],
	#category : #'GToolkit4Ruby-Importer'
}

{ #category : #importing }
GtRubyImporter >> addSourceFor: aNode to: anEntity [
	| anchor |
	anchor := self sourceAnchorFor: aNode.
	anEntity sourceAnchor isNil
		ifTrue: [ ^ anEntity sourceAnchor: anchor ].
	(anEntity sourceAnchor isKindOf: FAMIXMultipleFileAnchor)
		ifFalse: [ anEntity
				sourceAnchor:
					(FAMIXMultipleFileAnchor new
						mooseModel: mooseModel;
						addSourceAnchor: anEntity sourceAnchor;
						yourself) ].
	anEntity sourceAnchor addSourceAnchor: (self sourceAnchorFor: aNode)
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> addVariablesFrom: aLiteralArray to: aClass [
	2 to: aLiteralArray size by: 2 do: [ :i | 
		(aClass definesVariable: (aLiteralArray at: i) asString)
			ifFalse: [ aClass addInstanceVariable: (aLiteralArray at: i) asString ] ]
]

{ #category : #importing }
GtRubyImporter >> assignScope: modelObject around: aBlock [
	scopeStack addLast: modelObject.
	^ aBlock
		ensure: [ scopeStack removeLast ]
]

{ #category : #accessing }
GtRubyImporter >> baseDirectory [
	^ mooseModel rootFolder
]

{ #category : #accessing }
GtRubyImporter >> baseDirectory: aFileReference [
	mooseModel rootFolder: aFileReference asFileReference
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> buildClassesFromDirectory: aString [
	| model variableTypes |
	model := self createInitialRubyParseNode.
	variableTypes := self initialVariableTypesFrom: model.
	(aString asFileReference allFiles select: [ :e | e extension = 'rb' ])
		do: [ :each | 
			| literalAST |
			literalAST := self loadASTAsLiteral: each.
			self createClassesFrom: literalAST into: model.
			self updateVariableTypes: variableTypes from: literalAST in: model ].
	self compileMethodsForVariables: variableTypes.
	^ model
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileCompositeNodeMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile:
			('<1s>: anOrderedCollection<r><t>self setParent: self <1s> to: nil.<r><t><1s> := anOrderedCollection.<r><t>self setParent: self <1s> to: self'
				expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileCompositeTokenMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile: ('<1s>: anOrderedCollection<r><t><1s> := anOrderedCollection' expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileInitializeMethodFor: names in: cls [
	cls
		compile:
			(String
				streamContents: [ :stream | 
					stream
						nextPutAll: 'initialize';
						cr;
						nextPutAll: '	super initialize'.
					names
						do: [ :each | 
							stream
								nextPut: $.;
								cr;
								tab;
								nextPutAll: each;
								nextPutAll: ' := OrderedCollection new: 2' ] ])
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileMethodsForVariables: variableTypes [
	variableTypes
		keysAndValuesDo: [ :cls :vars | 
			| nodes collectionNodes tokens collectionTokens other |
			nodes := Set new.
			collectionNodes := Set new.
			tokens := Set new.
			collectionTokens := Set new.
			other := Set new.
			vars
				keysAndValuesDo: [ :name :types | 
					(types includes: #node)
						ifTrue: [ (types includes: #token)
								ifTrue: [ other add: name.
									self compileOtherMethodFor: name in: cls ]
								ifFalse: [ (types includes: #composite)
										ifTrue: [ collectionNodes add: name.
											self compileCompositeNodeMethodFor: name in: cls ]
										ifFalse: [ nodes add: name.
											self compileNodeMethodFor: name in: cls ] ] ]
						ifFalse: [ (types includes: #composite)
								ifTrue: [ collectionTokens add: name.
									self compileCompositeTokenMethodFor: name in: cls ]
								ifFalse: [ tokens add: name.
									self compileTokenMethodFor: name in: cls ] ] ].
			(collectionNodes notEmpty or: [ collectionTokens notEmpty ])
				ifTrue: [ self
						compileInitializeMethodFor:
							(collectionNodes copy
								addAll: collectionTokens;
								yourself)
						in: cls ].
			self compileVariableMethodNamed: 'nodeVariables' for: nodes in: cls.
			self
				compileVariableMethodNamed: 'compositeNodeVariables'
				for: collectionNodes
				in: cls.
			self
				compileVariableMethodNamed: 'tokenVariables'
				for: tokens
				in: cls.
			self
				compileVariableMethodNamed: 'compositeTokenVariables'
				for: collectionTokens
				in: cls.
			self
				compileVariableMethodNamed: 'otherVariables'
				for: other
				in: cls ]
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileNodeMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile:
			('<1s>: aNode<r><t>self <1s> notNil ifTrue: [ self <1s> parent: nil ].<r><t><1s> := aNode.<r><t>self <1s> notNil ifTrue: [ self <1s> parent: self ]'
				expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileOtherMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile:
			('<1s>: anObject<r><t>self setParent: self <1s> to: nil.<r><t><1s> := anObject.<r><t>self setParent: self <1s> to: self'
				expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileTokenMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile: ('<1s>: aToken<r><t><1s> := aToken' expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> compileVariableMethodNamed: selector for: names in: cls [
	names isEmpty
		ifTrue: [ ^ self ].
	cls
		compile:
			(String
				streamContents: [ :stream | 
					stream
						nextPutAll: selector;
						cr;
						nextPutAll: '	^ #('.
					names asSortedCollection
						do: [ :each | stream nextPutAll: each ]
						separatedBy: [ stream space ].
					stream nextPut: $) ])
		classified: #generated
]

{ #category : #importing }
GtRubyImporter >> containerScope [
	scopeStack size to: 1 by: -1 do: [ :i | 
		((scopeStack at: i) isKindOf: FAMIXContainerEntity)
			ifTrue: [ ^ scopeStack at: i ] ].
	^ nil
]

{ #category : #parsing }
GtRubyImporter >> createASTFrom: aLiteralArray [
	(self isNodeLiteral: aLiteralArray)
		ifTrue: [ ^ self createNodeFrom: aLiteralArray ].
	(self isTokenLiteral: aLiteralArray)
		ifTrue: [ ^ self createTokenFrom: aLiteralArray ].
	^ aLiteralArray asOrderedCollection
		collect: [ :each | self createASTFrom: each ]
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createAcceptVisitorMethods [
	| model |
	model := self createInitialRubyParseNode.
	self createAcceptVisitorMethodsIn: model.
	^ model
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createAcceptVisitorMethodsIn: aModel [
	| class |
	class := aModel classNamed: #RubyProgramNode.
	class withAllSubclasses
		do: [ :cls | 
			| name |
			name := cls name copyFrom: 5 to: cls name size - 4.
			cls
				compile:
					('acceptVisitor: aVisitor<r><t>^ aVisitor visit<1s>: self'
						expandMacrosWith: name)
				classified: #generated ]
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createClassesFrom: aLiteralArray [
	| model |
	model := self createInitialRubyParseNode.
	self createClassesFrom: aLiteralArray into: model.
	^ model changes
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createClassesFrom: aLiteralArray into: aModel [
	| className class |
	(self isNodeLiteral: aLiteralArray)
		ifTrue: [ className := ('Ruby' , aLiteralArray first , 'Node') asSymbol.
			(class := aModel classNamed: className) isNil
				ifTrue: [ aModel
						defineClass:
							'RubyProgramNode subclass: #' , className
								,
									'
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby'''.
					class := aModel classNamed: className ].
			self addVariablesFrom: aLiteralArray to: class ].
	aLiteralArray
		do: [ :each | 
			each isArray
				ifTrue: [ self createClassesFrom: each into: aModel ] ]
]

{ #category : #parsing }
GtRubyImporter >> createCommentIntervalsFrom: aLiteralArray [
	^ (1 to: aLiteralArray size by: 2)
		collect: [ :i | (aLiteralArray at: i) to: (aLiteralArray at: i + 1) ]
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createInitialRubyParseNode [
	| mdl |
	mdl := RBNamespace new.
	(mdl classNamed: #RubyProgramNode) isNil
		ifTrue: [ mdl
				defineClass:
					'SmaCCParseNode subclass: #RubyProgramNode
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby''' ].
	^ mdl
]

{ #category : #parsing }
GtRubyImporter >> createNodeFrom: aLiteralArray [
	| class node |
	class := Smalltalk
		at: ('Ruby' , aLiteralArray first , 'Node') asSymbol.
	node := class new.
	2 to: aLiteralArray size by: 2 do: [ :i | 
		| name value |
		name := aLiteralArray at: i.
		name = #comments
			ifTrue:
				[ value := self createCommentIntervalsFrom: (aLiteralArray at: i + 1) ]
			ifFalse: [ value := self createASTFrom: (aLiteralArray at: i + 1) ].
		node perform: (name , ':') asSymbol with: value ].
	^ node
]

{ #category : #parsing }
GtRubyImporter >> createTokenFrom: aLiteralArray [
	^ SmaCCToken
		value: aLiteralArray first
		start: aLiteralArray last
		ids:
			(((GtRubyScanner keywordMap at: 1) includesKey: aLiteralArray first)
				ifTrue: [ #(2) ]
				ifFalse: [ #(1) ])
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createVisitor [
	| model |
	model := self createInitialRubyParseNode.
	self createVisitorIn: model.
	^ model
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> createVisitorIn: aModel [
	| class trait |
	class := aModel classNamed: #RubyProgramNode.
	trait := (aModel classNamed: #TRubyProgramNodeVisitor)
		ifNil: [ aModel
				smaccDefineTrait:
					'Trait named: #TRubyProgramNodeVisitor uses: TSmaCCParseNodeVisitor package: ''GToolkit4Ruby'''.
			aModel classNamed: #TRubyProgramNodeVisitor ].
	class withAllSubclasses
		do: [ :cls | 
			| name superName |
			name := cls name copyFrom: 5 to: cls name size - 4.
			superName := cls == class
				ifTrue: [ 'SmaCCParseNode' ]
				ifFalse: [ cls superclass name copyFrom: 5 to: cls superclass name size - 4 ].
			trait
				compile:
					('visit<1s>: aNode<r><t>^ self visit<2s>: aNode'
						expandMacrosWith: name
						with: superName)
				classified: #generated ].
	aModel
		defineClass:
			'Object subclass: #RubyProgramNodeVisitor
				uses: TRubyProgramNodeVisitor
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby'''
]

{ #category : #importing }
GtRubyImporter >> ensureClassNamed: aString [
	^ classesAndModules
		at: aString
		ifAbsentPut: [ | index name namespace module class |
			index := aString lastIndexOf: $:.
			name := index > 0
				ifTrue: [ aString allButFirst: index ]
				ifFalse: [ aString ].
			class := GtRubyClass new name: name.
			index > 2
				ifTrue: [ namespace := aString first: index - 2.
					module := self ensureModuleNamed: namespace.
					class rubyContainer: module ].
			mooseModel add: class ]
]

{ #category : #importing }
GtRubyImporter >> ensureFileNamed: aFileReference [
	| filename |
	filename := aFileReference pathString.
	DiskStore activeClass isCaseSensitive
		ifFalse: [ filename := filename asUppercase ].
	^ files
		at: filename
		ifAbsentPut: [ | file |
			file := FAMIXFile new.
			file name: aFileReference basename.
			aFileReference exists
				ifTrue: [ | encoding anchor |
					encoding := [ aFileReference
						binaryReadStreamDo: [ :in | (ZnCharacterEncoder detectEncoding: in upToEnd) identifier ] ]
						on: Error
						do: [ :ex | ex return: 'utf-8' ].
					anchor := FAMIXIndexedFileEntityAnchor
						file: file
						startPos: 1
						endPos:
							(aFileReference
								readStreamEncoded: encoding
								do: [ :stream | stream contents size ])
						model: mooseModel.
					file sourceAnchor: anchor ]
				ifFalse: [ file isStub: true ].
			(self ensureFolderNamed: aFileReference parent)
				ifNotNil: [ :folder | folder addChildFileSystemEntity: file ].
			mooseModel add: file.
			file ]
]

{ #category : #importing }
GtRubyImporter >> ensureFolderNamed: aFileReference [
	^ folders
		at: aFileReference pathString
		ifAbsentPut: [ | folder |
			folder := FAMIXFolder new.
			aFileReference = mooseModel rootFolder
				ifTrue: [ folder name: '.' ]
				ifFalse: [ folder name: aFileReference basename.
					(self ensureFolderNamed: aFileReference parent)
						ifNotNil: [ :outer | outer addChildFileSystemEntity: folder ] ].
			mooseModel add: folder.
			folder ]
]

{ #category : #importing }
GtRubyImporter >> ensureFunctionNamed: aString [
	^ mooseModel add: (FAMIXFunction new name: aString)
]

{ #category : #importing }
GtRubyImporter >> ensureMethodNamed: aString [
	^ mooseModel add: (FAMIXMethod new name: aString)
]

{ #category : #importing }
GtRubyImporter >> ensureModuleNamed: aString [
	^ classesAndModules
		at: aString
		ifAbsentPut: [ | index name namespace parentModule module |
			index := aString lastIndexOf: $:.
			name := index > 0
				ifTrue: [ aString allButFirst: index ]
				ifFalse: [ aString ].
			module := GtRubyModule new name: name.
			index > 2
				ifTrue: [ namespace := aString first: index - 2.
					parentModule := self ensureModuleNamed: namespace.
					module rubyContainer: parentModule ].
			mooseModel add: module ]
]

{ #category : #importing }
GtRubyImporter >> fullNameFor: aString [
	| name |
	name := aString first = $:
		ifTrue: [ aString allButFirst: 2 ]
		ifFalse: [ aString ].
	(name includes: $:)
		ifTrue: [ ^ name ].
	^ (self containerScope
		ifNotNil: [ :each | each mooseName , '::' ]
		ifNil: [ '' ]) , name
]

{ #category : #importing }
GtRubyImporter >> getParametersFor: anObject [
	| current |
	current := anObject.
	[ current isKindOf: Collection ]
		whileTrue: [ current := current anyOne ].
	^ current
]

{ #category : #importing }
GtRubyImporter >> importAST: aNode [
	self accept: aNode
]

{ #category : #importing }
GtRubyImporter >> importASTs: aCollection [
	aCollection do: [ :each | self importAST: each ]
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> initialVariableTypesFrom: aModel [
	| types |
	types := Dictionary new.
	(aModel classNamed: #RubyProgramNode)
		ifNotNil: [ :cls | 
			cls
				allSubclassesDo: [ :sub | 
					#(#(compositeNodeVariables #(composite node)) #(compositeTokenVariables #(composite token)) #(nodeVariables #(node)) #(tokenVariables #(token)) #(otherVariables #(token node)))
						do: [ :entry | 
							| selector varTypes |
							selector := entry first.
							varTypes := entry last.
							((sub methodFor: selector)
								ifNotNil: [ :method | self literalArrayFor: method ]
								ifNil: [ #() ])
								do: [ :each | 
									(types at: sub ifAbsentPut: [ Dictionary new ])
										at: each
										put: varTypes asSet ] ] ] ].
	^ types
]

{ #category : #'initialize-release' }
GtRubyImporter >> initialize [
	super initialize.
	mooseModel := MooseModel new.
	mooseModel sourceLanguage: FAMIXRubySourceLanguage new.
	scopeStack := OrderedCollection new.
	folders := Dictionary new.
	files := Dictionary new.
	classesAndModules := Dictionary new
]

{ #category : #testing }
GtRubyImporter >> isNodeLiteral: anArray [
	^ anArray notEmpty and: [ anArray first isSymbol ]
]

{ #category : #testing }
GtRubyImporter >> isTokenLiteral: anArray [
	^ anArray notEmpty
		and: [ anArray first isSymbol not and: [ anArray first isString ] ]
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> literalArrayFor: aMethod [
	aMethod parseTree
		nodesDo: [ :each | 
			each isLiteralArray
				ifTrue: [ ^ each value ] ].
	^ #()
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> loadASTAsLiteral: aFilename [
	| command stream scriptDirectory |
	scriptDirectory := GtResourcesUtility default
		resourceAtPath: Path * 'feenkcom/gt4ruby/ruby/'.
	command := OSSUnixSubprocess new
		shellCommand:
			'ruby "' , scriptDirectory fullName , '/write-ast.rb" "'
				, aFilename fullName , '"';
		workingDirectory: scriptDirectory fullName;
		redirectStdout.
	command run.
	stream := WriteStream on: String new.
	[ stream nextPutAll: command stdoutStream upToEndOfFile.
	command isRunning ] whileTrue.
	command waitForExit.
	stream nextPutAll: command stdoutStream upToEndOfFile.
	command closeAndCleanStreams.
	^ (RBParser parseExpression: stream contents) value
]

{ #category : #accessing }
GtRubyImporter >> model [
	^ mooseModel
]

{ #category : #parsing }
GtRubyImporter >> parseDirectory: aString [
	self baseDirectory: aString asFileReference.
	^ (aString asFileReference allFiles
		select: [ :e | e extension = 'rb' ])
		collect: [ :each | self parseFile: each ]
]

{ #category : #parsing }
GtRubyImporter >> parseFile: aFileReference [
	| node |
	node := [ | literalAST |
	literalAST := self loadASTAsLiteral: aFileReference.
	self createASTFrom: literalAST ]
		on: Error
		do: [ :ex | ex return: SmaCCErrorNode new ].
	node completeSource: aFileReference contents.
	node filename: aFileReference fullName.
	^ node
]

{ #category : #importing }
GtRubyImporter >> sourceAnchorFor: aNode [
	^ FAMIXIndexedFileEntityAnchor
		file: currentFile
		startPos: aNode startPosition
		endPos: aNode stopPosition
		model: mooseModel
]

{ #category : #importing }
GtRubyImporter >> storeAST: aNode into: anEntity [
	anEntity propertyNamed: #ast put: aNode
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> typeFor: aLiteralArray [
	| types |
	aLiteralArray isEmpty
		ifTrue: [ ^ #() ].
	aLiteralArray first isSymbol
		ifTrue: [ ^ #(node) ].
	aLiteralArray first isString
		ifTrue: [ ^ #(token) ].
	types := Set new.
	(aLiteralArray first isKindOf: Array)
		ifTrue: [ types add: #composite.
			aLiteralArray do: [ :each | types addAll: (self typeFor: each) ] ].
	^ types
]

{ #category : #'generating ast node classes' }
GtRubyImporter >> updateVariableTypes: variableTypes from: aLiteralArray in: aModel [
	| class className |
	(self isNodeLiteral: aLiteralArray)
		ifTrue: [ className := ('Ruby' , aLiteralArray first , 'Node') asSymbol.
			class := aModel classNamed: className.
			2 to: aLiteralArray size by: 2 do: [ :i | 
				| varName |
				varName := aLiteralArray at: i.
				varName = #comments
					ifFalse: [ ((variableTypes at: class ifAbsentPut: [ Dictionary new ])
							at: varName
							ifAbsentPut: [ Set new ])
							addAll: (self typeFor: (aLiteralArray at: i + 1)) ] ] ].
	aLiteralArray
		do: [ :each | 
			each isArray
				ifTrue: [ self updateVariableTypes: variableTypes from: each in: aModel ] ]
]

{ #category : #visiting }
GtRubyImporter >> visitClass: aNode [
	| class |
	class := self ensureClassNamed: (self fullNameFor: aNode name source).
	self storeAST: aNode into: class.
	currentFile addEntity: class.
	self addSourceFor: aNode to: class.
	^ self assignScope: class around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtRubyImporter >> visitFile: aNode [
	scopeStack := OrderedCollection new.
	currentFile := self ensureFileNamed: aNode filename asFileReference.
	self storeAST: aNode into: currentFile.
	^ self visitProgram: aNode
]

{ #category : #visiting }
GtRubyImporter >> visitMethod: aNode [
	| method container |
	container := self containerScope.
	method := (container isKindOf: FAMIXClass)
		ifTrue: [ self ensureMethodNamed: aNode name source ]
		ifFalse: [ self ensureFunctionNamed: aNode name source ].
	self storeAST: aNode into: method.
	currentFile addEntity: method.
	(container isKindOf: FAMIXClass)
		ifTrue: [ method parentType: container ]
		ifFalse: [ method container: container ].
	method sourceAnchor: (self sourceAnchorFor: aNode).
	method
		signature:
			(String
				streamContents: [ :stream | 
					| p |
					stream nextPutAll: aNode name source.
					p := self getParametersFor: aNode params.
					stream nextPut: $(.
					(p variables ifNil: [ #() ])
						do: [ :each | stream nextPutAll: each variableName ]
						separatedBy: [ stream nextPutAll: ', ' ].
					stream nextPut: $) ]).
	^ self
		assignScope: method
		around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtRubyImporter >> visitModule: aNode [
	| module |
	module := self
		ensureModuleNamed: (self fullNameFor: aNode name source).
	self storeAST: aNode into: module.
	currentFile addEntity: module.
	self addSourceFor: aNode to: module.
	^ self
		assignScope: module
		around: [ self visitSmaCCParseNode: aNode ]
]
