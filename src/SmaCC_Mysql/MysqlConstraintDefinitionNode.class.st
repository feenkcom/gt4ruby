Class {
	#name : #MysqlConstraintDefinitionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'primaryToken',
		'keyToken',
		'leftParens',
		'columnNames',
		'directions',
		'lengths',
		'rightParens',
		'exprs',
		'commas',
		'option',
		'usingToken',
		'btreeToken',
		'hashToken',
		'constraintToken',
		'constraintName',
		'uniqueToken',
		'indexName',
		'indexToken',
		'foreignToken',
		'referencesToken',
		'tableName',
		'onTokens',
		'updateToken',
		'restrictTokens',
		'cascadeTokens',
		'setTokens',
		'nullTokens',
		'noTokens',
		'actionTokens',
		'defaultTokens',
		'_deleteToken',
		'matchToken',
		'fullToken',
		'partialToken',
		'simpleToken',
		'checkToken',
		'check',
		'enforcedToken',
		'notToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlConstraintDefinitionNode >> _deleteToken [
	^ _deleteToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> _deleteToken: aSmaCCToken [
	_deleteToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitConstraintDefinition: self
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> actionTokens [
	^ actionTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> actionTokens: anOrderedCollection [
	actionTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> btreeToken [
	^ btreeToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> btreeToken: aSmaCCToken [
	btreeToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> cascadeTokens [
	^ cascadeTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> cascadeTokens: anOrderedCollection [
	cascadeTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> check [
	^ check
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> check: aSmaCCErrorNode [
	self check notNil
		ifTrue: [ self check parent: nil ].
	check := aSmaCCErrorNode.
	self check notNil
		ifTrue: [ self check parent: self ]
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> checkToken [
	^ checkToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> checkToken: aSmaCCToken [
	checkToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> columnNames [
	^ columnNames
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> columnNames: anOrderedCollection [
	columnNames := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> commas [
	^ commas
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> compositeNodeVariables [
	^ #(#exprs)
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> compositeTokenVariables [
	^ #(#leftParens #columnNames #directions #lengths #rightParens #commas #onTokens #restrictTokens #cascadeTokens #setTokens #nullTokens #noTokens #actionTokens #defaultTokens)
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> constraintName [
	^ constraintName
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> constraintName: aSmaCCErrorNode [
	self constraintName notNil
		ifTrue: [ self constraintName parent: nil ].
	constraintName := aSmaCCErrorNode.
	self constraintName notNil
		ifTrue: [ self constraintName parent: self ]
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> constraintToken [
	^ constraintToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> constraintToken: aSmaCCToken [
	constraintToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> defaultTokens [
	^ defaultTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> defaultTokens: anOrderedCollection [
	defaultTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> directions [
	^ directions
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> directions: anOrderedCollection [
	directions := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> enforcedToken [
	^ enforcedToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> enforcedToken: aSmaCCToken [
	enforcedToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> exprs [
	^ exprs
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> exprs: anOrderedCollection [
	self setParents: self exprs to: nil.
	exprs := anOrderedCollection.
	self setParents: self exprs to: self
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> foreignToken [
	^ foreignToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> foreignToken: aSmaCCToken [
	foreignToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> fullToken [
	^ fullToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> fullToken: aSmaCCToken [
	fullToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> hashToken [
	^ hashToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> hashToken: aSmaCCToken [
	hashToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> indexName [
	^ indexName
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> indexName: aSmaCCToken [
	indexName := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> indexToken [
	^ indexToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> indexToken: aSmaCCToken [
	indexToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlConstraintDefinitionNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	columnNames := OrderedCollection new: 2.
	directions := OrderedCollection new: 2.
	lengths := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
	exprs := OrderedCollection new: 2.
	commas := OrderedCollection new: 2.
	onTokens := OrderedCollection new: 2.
	restrictTokens := OrderedCollection new: 2.
	cascadeTokens := OrderedCollection new: 2.
	setTokens := OrderedCollection new: 2.
	nullTokens := OrderedCollection new: 2.
	noTokens := OrderedCollection new: 2.
	actionTokens := OrderedCollection new: 2.
	defaultTokens := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> keyToken [
	^ keyToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> keyToken: aSmaCCToken [
	keyToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> lengths [
	^ lengths
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> lengths: anOrderedCollection [
	lengths := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> matchToken [
	^ matchToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> matchToken: aSmaCCToken [
	matchToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> noTokens [
	^ noTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> noTokens: anOrderedCollection [
	noTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> nodeVariables [
	^ #(#option #constraintName #check)
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> notToken [
	^ notToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> notToken: aSmaCCToken [
	notToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> nullTokens [
	^ nullTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> nullTokens: anOrderedCollection [
	nullTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> onTokens [
	^ onTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> onTokens: anOrderedCollection [
	onTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> option [
	^ option
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> option: aMysqlIndexOptionNode [
	self option notNil
		ifTrue: [ self option parent: nil ].
	option := aMysqlIndexOptionNode.
	self option notNil
		ifTrue: [ self option parent: self ]
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> partialToken [
	^ partialToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> partialToken: aSmaCCToken [
	partialToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> primaryToken [
	^ primaryToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> primaryToken: aSmaCCToken [
	primaryToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> referencesToken [
	^ referencesToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> referencesToken: aSmaCCToken [
	referencesToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> restrictTokens [
	^ restrictTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> restrictTokens: anOrderedCollection [
	restrictTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> setTokens [
	^ setTokens
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> setTokens: anOrderedCollection [
	setTokens := anOrderedCollection
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> simpleToken [
	^ simpleToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> simpleToken: aSmaCCToken [
	simpleToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> tableName [
	^ tableName
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> tableName: aSmaCCToken [
	tableName := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> tokenVariables [
	^ #(#primaryToken #keyToken #usingToken #btreeToken #hashToken #constraintToken #uniqueToken #indexName #indexToken #foreignToken #referencesToken #tableName #updateToken #_deleteToken #matchToken #fullToken #partialToken #simpleToken #checkToken #enforcedToken #notToken)
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> uniqueToken [
	^ uniqueToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> uniqueToken: aSmaCCToken [
	uniqueToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> updateToken [
	^ updateToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> updateToken: aSmaCCToken [
	updateToken := aSmaCCToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> usingToken [
	^ usingToken
]

{ #category : #generated }
MysqlConstraintDefinitionNode >> usingToken: aSmaCCToken [
	usingToken := aSmaCCToken
]
