Class {
	#name : #GtRubyImporter,
	#superclass : #Object,
	#category : #GToolkit4Ruby
}

{ #category : #'generating ast node classes' }
GtRubyImporter >> addVariablesFrom: aLiteralArray to: aClass [
	2 to: aLiteralArray size by: 2 do: [ :i | 
		(aClass definesVariable: (aLiteralArray at: i) asString)
			ifFalse: [ aClass addInstanceVariable: (aLiteralArray at: i) asString ] ]
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
	| model |
	model := RBNamespace new.
	(model classNamed: #RubyProgramNode) isNil
		ifTrue: [ model
				defineClass:
					'SmaCCParseNode subclass: #RubyProgramNode
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby''' ].
	^ model
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
		ids: #()
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

{ #category : #parsing }
GtRubyImporter >> parseDirectory: aString [
	^ (aString asFileReference allFiles
		select: [ :e | e extension = 'rb' ])
		collect: [ :each | 
			| literalAST node |
			literalAST := self loadASTAsLiteral: each.
			node := self createASTFrom: literalAST.
			node completeSource: each contents.
			node filename: each fullName.
			node ]
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
