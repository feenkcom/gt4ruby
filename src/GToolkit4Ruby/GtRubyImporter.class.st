Class {
	#name : #GtRubyImporter,
	#superclass : #Object,
	#category : #GToolkit4Ruby
}

{ #category : #accessing }
GtRubyImporter >> addVariablesFrom: aLiteralArray to: aClass [
	2 to: aLiteralArray size by: 2 do: [ :i | 
		(aClass definesVariable: (aLiteralArray at: i) asString)
			ifFalse: [ aClass addInstanceVariable: (aLiteralArray at: i) asString ] ]
]

{ #category : #accessing }
GtRubyImporter >> buildClassesFromDirectory: aString [
	| model |
	model := self createInitialRubyParseNode.
	(aString asFileReference allFiles select: [ :e | e extension = 'rb' ])
		do:
			[ :each | self createClassesFrom: (self loadASTAsLiteral: each) into: model ].
	^ model
]

{ #category : #accessing }
GtRubyImporter >> createClassesFrom: aLiteralArray [
	| model |
	model := self createInitialRubyParseNode.
	self createClassesFrom: aLiteralArray into: model.
	^ model changes
]

{ #category : #accessing }
GtRubyImporter >> createClassesFrom: aLiteralArray into: aModel [
	| className class |
	aLiteralArray isEmpty
		ifTrue: [ ^ self ].
	aLiteralArray first isSymbol
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

{ #category : #accessing }
GtRubyImporter >> createInitialRubyParseNode [
	| model |
	model := RBNamespace new.
	model
		defineClass:
			'SmaCCParseNode subclass: #RubyProgramNode
				instanceVariableNames: ''''
				classVariableNames: ''''
				poolDictionaries: ''''
				package: ''GToolkit4Ruby'''.
	^ model
]

{ #category : #accessing }
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
