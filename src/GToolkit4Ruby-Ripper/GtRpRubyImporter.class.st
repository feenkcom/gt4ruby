Class {
	#name : #GtRpRubyImporter,
	#superclass : #GtRubyImporter,
	#traits : 'TRpRubyProgramNodeVisitor - {#visitFile:}',
	#classTraits : 'TRpRubyProgramNodeVisitor classTrait',
	#category : #'GToolkit4Ruby-Ripper-Importer'
}

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> addVariablesFrom: aLiteralArray to: aClass [
	2 to: aLiteralArray size by: 2 do: [ :i | 
		(aClass definesVariable: (aLiteralArray at: i) asString)
			ifFalse: [ aClass addInstanceVariable: (aLiteralArray at: i) asString ] ]
]

{ #category : #accessing }
GtRpRubyImporter >> baseDirectory [
	^ mooseModel rootFolder
]

{ #category : #accessing }
GtRpRubyImporter >> baseDirectory: aFileReference [
	mooseModel rootFolder: aFileReference asFileReference
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> buildClassesFromDirectory: aString [
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

{ #category : #accessing }
GtRpRubyImporter >> classesAndModules [
	^ classesAndModules
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> compileCompositeNodeMethodFor: name in: cls [
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
GtRpRubyImporter >> compileCompositeTokenMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile: ('<1s>: anOrderedCollection<r><t><1s> := anOrderedCollection' expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> compileInitializeMethodFor: names in: cls [
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
GtRpRubyImporter >> compileMethodsForVariables: variableTypes [
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
GtRpRubyImporter >> compileNodeMethodFor: name in: cls [
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
GtRpRubyImporter >> compileOtherMethodFor: name in: cls [
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
GtRpRubyImporter >> compileTokenMethodFor: name in: cls [
	cls
		compile: ('<1s><r><t>^ <1s>' expandMacrosWith: name)
		classified: #generated.
	cls
		compile: ('<1s>: aToken<r><t><1s> := aToken' expandMacrosWith: name)
		classified: #generated
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> compileVariableMethodNamed: selector for: names in: cls [
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

{ #category : #parsing }
GtRpRubyImporter >> createASTCacheIn: aDirectory [
	| scriptDirectory command |
	scriptDirectory := GtResourcesUtility default
		resourceAtPath: Path * 'feenkcom/gt4ruby/ruby/'.
	command := OSSUnixSubprocess new
		shellCommand:
			'ruby "' , scriptDirectory fullName , '/write-ast-dir.rb" "'
				, aDirectory asFileReference fullName , '"';
		workingDirectory: scriptDirectory fullName.
	command run.
	command waitForExit
]

{ #category : #parsing }
GtRpRubyImporter >> createASTFrom: aLiteralArray [
	(self isNodeLiteral: aLiteralArray)
		ifTrue: [ ^ self createNodeFrom: aLiteralArray ].
	(self isTokenLiteral: aLiteralArray)
		ifTrue: [ ^ self createTokenFrom: aLiteralArray ].
	^ aLiteralArray asOrderedCollection
		collect: [ :each | self createASTFrom: each ]
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> createAcceptVisitorMethods [
	| model |
	model := self createInitialRubyParseNode.
	self createAcceptVisitorMethodsIn: model.
	^ model
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> createAcceptVisitorMethodsIn: aModel [
	| class |
	class := aModel classNamed: #RpRubyProgramNode.
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
GtRpRubyImporter >> createClassesFrom: aLiteralArray [
	| model |
	model := self createInitialRubyParseNode.
	self createClassesFrom: aLiteralArray into: model.
	^ model changes
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> createClassesFrom: aLiteralArray into: aModel [
	| className class |
	(self isNodeLiteral: aLiteralArray)
		ifTrue: [ className := ('RpRuby' , aLiteralArray first , 'Node') asSymbol.
			(class := aModel classNamed: className) isNil
				ifTrue: [ aModel
						defineClass:
							'RpRubyProgramNode subclass: #' , className
								,
									'
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby-Ripper'''.
					class := aModel classNamed: className ].
			self addVariablesFrom: aLiteralArray to: class ].
	aLiteralArray
		do: [ :each | 
			each isArray
				ifTrue: [ self createClassesFrom: each into: aModel ] ]
]

{ #category : #parsing }
GtRpRubyImporter >> createCommentIntervalsFrom: aLiteralArray [
	^ (1 to: aLiteralArray size by: 2)
		collect: [ :i | (aLiteralArray at: i) to: (aLiteralArray at: i + 1) ]
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> createInitialRubyParseNode [
	| mdl |
	mdl := RBNamespace new.
	(mdl classNamed: #RpRubyProgramNode) isNil
		ifTrue: [ mdl
				defineClass:
					'SmaCCParseNode subclass: #RpRubyProgramNode
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby-Ripper''' ].
	^ mdl
]

{ #category : #parsing }
GtRpRubyImporter >> createNodeFrom: aLiteralArray [
	| class node |
	class := Smalltalk
		at: ('RpRuby' , aLiteralArray first , 'Node') asSymbol.
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
GtRpRubyImporter >> createTokenFrom: aLiteralArray [
	^ SmaCCToken
		value: aLiteralArray first
		start: aLiteralArray last
		ids:
			(((RpRubyScanner keywordMap at: 1) includesKey: aLiteralArray first)
				ifTrue: [ #(2) ]
				ifFalse: [ #(1) ])
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> createVisitor [
	| model |
	model := self createInitialRubyParseNode.
	self createVisitorIn: model.
	^ model
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> createVisitorIn: aModel [
	| class trait |
	class := aModel classNamed: #RpRubyProgramNode.
	trait := (aModel classNamed: #TRpRubyProgramNodeVisitor)
		ifNil: [ aModel
				smaccDefineTrait:
					'Trait named: #TRpRubyProgramNodeVisitor uses: TSmaCCParseNodeVisitor package: ''GToolkit4Ruby-Ripper'''.
			aModel classNamed: #TRpRubyProgramNodeVisitor ].
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
			'Object subclass: #RpRubyProgramNodeVisitor
				uses: TRubyProgramNodeVisitor
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby-Ripper'''
]

{ #category : #accessing }
GtRpRubyImporter >> currentFile [
	^ currentFile
]

{ #category : #importing }
GtRpRubyImporter >> findTableForClass: aClass [
	| tableName |
	tableName := SmaCCVariableDefinition
		pluralNameFor:
			(String
				streamContents: [ :stream | 
					aClass name
						keysAndValuesDo: [ :i :each | 
							i == 1
								ifFalse: [ each isUppercase
										ifTrue: [ stream nextPut: $_ ] ].
							stream nextPut: each asLowercase ] ]).
	^ tables
		at: tableName
		ifAbsent: [ (aClass propertyNamed: #ast)
				ifNotNil: [ :node | 
					node body statements
						do: [ :each | 
							((each isKindOf: RpRubyAssignmentNode)
								and: [ each lhs source = 'self.table_name' ])
								ifTrue: [ ^ tables
										at: (self stripQuotesFrom: each value source)
										ifAbsent: [  ] ] ] ].
			nil ]
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> initialVariableTypesFrom: aModel [
	| types |
	types := Dictionary new.
	(aModel classNamed: #RpRubyProgramNode)
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

{ #category : #testing }
GtRpRubyImporter >> isAssignment: aNode [
	^ aNode isKindOf: RpRubyAssignmentNode
]

{ #category : #testing }
GtRpRubyImporter >> isNodeLiteral: anArray [
	^ anArray notEmpty and: [ anArray first isSymbol ]
]

{ #category : #testing }
GtRpRubyImporter >> isTokenLiteral: anArray [
	^ anArray notEmpty
		and: [ anArray first isSymbol not and: [ anArray first isString ] ]
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> literalArrayFor: aMethod [
	aMethod parseTree
		nodesDo: [ :each | 
			each isLiteralArray
				ifTrue: [ ^ each value ] ].
	^ #()
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> loadASTAsLiteral: aFilename [
	| command stream scriptDirectory |
	NonInteractiveTranscript stdout nextPutAll: aFilename asString; cr.
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
GtRpRubyImporter >> model [
	^ mooseModel
]

{ #category : #accessing }
GtRpRubyImporter >> model: aModel [
	mooseModel := aModel
]

{ #category : #importing }
GtRpRubyImporter >> namespaceFrom: aNode [
	| current ns name |
	ns := ''.
	current := aNode.
	[ current notNil ]
		whileTrue: [ ((current isKindOf: RpRubyCallNode)
				and: [ current name source = 'namespace' ])
				ifTrue: [ name := current arguments arguments first source.
					ns := name first = $:
						ifTrue: [ name allButFirst , '::' , ns ]
						ifFalse: [ (self stripQuotesFrom: name) , '::' , ns ] ].
			current := current parent ].
	^ ns
]

{ #category : #parsing }
GtRpRubyImporter >> parseCachedDirectory: aString [
	self baseDirectory: aString asFileReference.
	^ (aString asFileReference allFiles
		select: [ :e | e extension = 'ast' ])
		collect: [ :each | self parseCachedFile: each ]
]

{ #category : #parsing }
GtRpRubyImporter >> parseCachedFile: aFileReference [
	| node rubyName |
	node := [ | literalAST |
	literalAST := (RBParser parseExpression: aFileReference contents)
		value.
	self createASTFrom: literalAST ]
		on: Error
		do: [ :ex | ex return: SmaCCErrorNode new ].
	rubyName := aFileReference fullName allButLast: 4.
	node completeSource: rubyName asFileReference contents.
	node filename: rubyName.
	^ node
]

{ #category : #parsing }
GtRpRubyImporter >> parseFile: aFileReference [
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
GtRpRubyImporter >> processRouteFiles [
	| first |
	first := true.
	[ routeFiles notEmpty ]
		whileTrue: [ currentFile := routeFiles first attributeNamed: #entity.
			GtRpRubyRouteImporter new
				importer: self;
				insideDraw: first not;
				accept: routeFiles removeFirst.
			first := false ]
]

{ #category : #importing }
GtRpRubyImporter >> processSchemaCall: aNode [
	| name |
	name := aNode name source.
	name = 'create_table'
		ifTrue: [ | tableName |
			tableName := self
				stripQuotesFrom: aNode arguments arguments first source.
			currentTable := GtTable new name: tableName.
			mooseModel add: currentTable.
			self storeAST: aNode into: currentTable.
			currentFile addEntity: currentTable.
			self addSourceFor: aNode to: currentTable.
			tables at: tableName put: currentTable.
			aNode arguments arguments
				do: [ :each | 
					(each isKindOf: RpRubyAssociationArgumentsNode)
						ifTrue: [ each args
								do: [ :assoc | 
									assoc key source = 'id:'
										ifTrue: [ | column |
											column := GtTableColumn new name: 'id'.
											mooseModel add: column.
											self storeAST: assoc into: column.
											currentFile addEntity: column.
											self addSourceFor: assoc to: column.
											currentTable addAttribute: column ] ] ] ].
			self visitProgram: aNode.
			currentTable := nil.
			^ self ]
		ifFalse: [ (currentTable notNil
				and:
					[ #('binary' 'boolean' 'date' 'datetime' 'decimal' 'float' 'integer' 'primary_key' 'string' 'text' 'time' 'timestamp')
						includes: name ])
				ifTrue: [ | column |
					column := GtTableColumn new
						name: (self stripQuotesFrom: aNode arguments arguments first source).
					mooseModel add: column.
					self storeAST: aNode into: column.
					currentFile addEntity: column.
					self addSourceFor: aNode to: column.
					currentTable addAttribute: column ] ].
	^ self visitProgram: aNode
]

{ #category : #accessing }
GtRpRubyImporter >> rootUrl [
	^ rootUrl
]

{ #category : #'generating ast node classes' }
GtRpRubyImporter >> typeFor: aLiteralArray [
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
GtRpRubyImporter >> updateVariableTypes: variableTypes from: aLiteralArray in: aModel [
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
GtRpRubyImporter >> visitCall: aNode [
	insideSchemaFile
		ifTrue: [ ^ self processSchemaCall: aNode ].
	^ self visitProgram: aNode
]

{ #category : #visiting }
GtRpRubyImporter >> visitClass: aNode [
	| class |
	class := self ensureClassNamed: (self fullNameFor: aNode name source).
	aNode superclass
		ifNotNil: [ :spr | 
			superclasses
				add:
					{class.
					spr source} ].
	self storeAST: aNode into: class.
	currentFile addEntity: class.
	self addSourceFor: aNode to: class.
	^ self assignScope: class around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtRpRubyImporter >> visitMethod: aNode [
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
GtRpRubyImporter >> visitModule: aNode [
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

{ #category : #visiting }
GtRpRubyImporter >> visitVariable: aNode [
	| name |
	name := aNode name source.
	(name beginsWith: '@@')
		ifTrue: [ self createClassVariableReferenceFrom: aNode ]
		ifFalse: [ (name beginsWith: '@')
				ifTrue: [ self createInstanceVariableReferenceFrom: aNode ] ].
	^ self visitProgram: aNode
]
