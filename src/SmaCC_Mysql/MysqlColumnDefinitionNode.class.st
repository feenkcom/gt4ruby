Class {
	#name : #MysqlColumnDefinitionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'columnName',
		'dataType',
		'visibleToken',
		'invisibleToken',
		'autoIncrementToken',
		'uniqueToken',
		'keyTokens',
		'primaryToken',
		'commentToken',
		'collateToken',
		'collationName',
		'columnFormatToken',
		'columnFormat',
		'engineAttributeToken',
		'engineAttribute',
		'equalses',
		'secondaryToken',
		'secondaryEngineAttribute',
		'storageToken',
		'diskToken',
		'memoryToken',
		'referencesToken',
		'tableName',
		'leftParens',
		'refColumnNames',
		'directions',
		'lengths',
		'rightParens',
		'exprs',
		'commas',
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
		'notTokens',
		'constraintToken',
		'constraintName',
		'value',
		'asToken',
		'generated',
		'virtualToken',
		'storedToken',
		'generatedToken',
		'alwaysToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlColumnDefinitionNode >> _deleteToken [
	^ _deleteToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> _deleteToken: aSmaCCToken [
	_deleteToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitColumnDefinition: self
]

{ #category : #generated }
MysqlColumnDefinitionNode >> actionTokens [
	^ actionTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> actionTokens: anOrderedCollection [
	actionTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> alwaysToken [
	^ alwaysToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> alwaysToken: aSmaCCToken [
	alwaysToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> asToken [
	^ asToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> asToken: aSmaCCToken [
	asToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> autoIncrementToken [
	^ autoIncrementToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> autoIncrementToken: aSmaCCToken [
	autoIncrementToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> cascadeTokens [
	^ cascadeTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> cascadeTokens: anOrderedCollection [
	cascadeTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> check [
	^ check
]

{ #category : #generated }
MysqlColumnDefinitionNode >> check: aSmaCCErrorNode [
	self check notNil
		ifTrue: [ self check parent: nil ].
	check := aSmaCCErrorNode.
	self check notNil
		ifTrue: [ self check parent: self ]
]

{ #category : #generated }
MysqlColumnDefinitionNode >> checkToken [
	^ checkToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> checkToken: aSmaCCToken [
	checkToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> collateToken [
	^ collateToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> collateToken: aSmaCCToken [
	collateToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> collationName [
	^ collationName
]

{ #category : #generated }
MysqlColumnDefinitionNode >> collationName: aSmaCCToken [
	collationName := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> columnFormat [
	^ columnFormat
]

{ #category : #generated }
MysqlColumnDefinitionNode >> columnFormat: aSmaCCToken [
	columnFormat := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> columnFormatToken [
	^ columnFormatToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> columnFormatToken: aSmaCCToken [
	columnFormatToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> columnName [
	^ columnName
]

{ #category : #generated }
MysqlColumnDefinitionNode >> columnName: aSmaCCToken [
	columnName := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> commas [
	^ commas
]

{ #category : #generated }
MysqlColumnDefinitionNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> commentToken [
	^ commentToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> commentToken: aSmaCCToken [
	commentToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> compositeNodeVariables [
	^ #(#exprs)
]

{ #category : #generated }
MysqlColumnDefinitionNode >> compositeTokenVariables [
	^ #(#keyTokens #equalses #leftParens #refColumnNames #directions #lengths #rightParens #commas #onTokens #restrictTokens #cascadeTokens #setTokens #nullTokens #noTokens #actionTokens #defaultTokens #notTokens)
]

{ #category : #generated }
MysqlColumnDefinitionNode >> constraintName [
	^ constraintName
]

{ #category : #generated }
MysqlColumnDefinitionNode >> constraintName: aSmaCCErrorNode [
	self constraintName notNil
		ifTrue: [ self constraintName parent: nil ].
	constraintName := aSmaCCErrorNode.
	self constraintName notNil
		ifTrue: [ self constraintName parent: self ]
]

{ #category : #generated }
MysqlColumnDefinitionNode >> constraintToken [
	^ constraintToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> constraintToken: aSmaCCToken [
	constraintToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> dataType [
	^ dataType
]

{ #category : #generated }
MysqlColumnDefinitionNode >> dataType: aMysqlDataTypeNode [
	self dataType notNil
		ifTrue: [ self dataType parent: nil ].
	dataType := aMysqlDataTypeNode.
	self dataType notNil
		ifTrue: [ self dataType parent: self ]
]

{ #category : #generated }
MysqlColumnDefinitionNode >> defaultTokens [
	^ defaultTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> defaultTokens: anOrderedCollection [
	defaultTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> directions [
	^ directions
]

{ #category : #generated }
MysqlColumnDefinitionNode >> directions: anOrderedCollection [
	directions := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> diskToken [
	^ diskToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> diskToken: aSmaCCToken [
	diskToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> enforcedToken [
	^ enforcedToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> enforcedToken: aSmaCCToken [
	enforcedToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> engineAttribute [
	^ engineAttribute
]

{ #category : #generated }
MysqlColumnDefinitionNode >> engineAttribute: aSmaCCToken [
	engineAttribute := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> engineAttributeToken [
	^ engineAttributeToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> engineAttributeToken: aSmaCCToken [
	engineAttributeToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> equalses [
	^ equalses
]

{ #category : #generated }
MysqlColumnDefinitionNode >> equalses: anOrderedCollection [
	equalses := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> exprs [
	^ exprs
]

{ #category : #generated }
MysqlColumnDefinitionNode >> exprs: anOrderedCollection [
	self setParents: self exprs to: nil.
	exprs := anOrderedCollection.
	self setParents: self exprs to: self
]

{ #category : #generated }
MysqlColumnDefinitionNode >> fullToken [
	^ fullToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> fullToken: aSmaCCToken [
	fullToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> generated [
	^ generated
]

{ #category : #generated }
MysqlColumnDefinitionNode >> generated: aSmaCCErrorNode [
	self generated notNil
		ifTrue: [ self generated parent: nil ].
	generated := aSmaCCErrorNode.
	self generated notNil
		ifTrue: [ self generated parent: self ]
]

{ #category : #generated }
MysqlColumnDefinitionNode >> generatedToken [
	^ generatedToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> generatedToken: aSmaCCToken [
	generatedToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlColumnDefinitionNode >> initialize [
	super initialize.
	keyTokens := OrderedCollection new: 2.
	equalses := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	refColumnNames := OrderedCollection new: 2.
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
	notTokens := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlColumnDefinitionNode >> invisibleToken [
	^ invisibleToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> invisibleToken: aSmaCCToken [
	invisibleToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> keyTokens [
	^ keyTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> keyTokens: anOrderedCollection [
	keyTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> lengths [
	^ lengths
]

{ #category : #generated }
MysqlColumnDefinitionNode >> lengths: anOrderedCollection [
	lengths := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> matchToken [
	^ matchToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> matchToken: aSmaCCToken [
	matchToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> memoryToken [
	^ memoryToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> memoryToken: aSmaCCToken [
	memoryToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> noTokens [
	^ noTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> noTokens: anOrderedCollection [
	noTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> nodeVariables [
	^ #(#dataType #check #constraintName #generated)
]

{ #category : #generated }
MysqlColumnDefinitionNode >> notTokens [
	^ notTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> notTokens: anOrderedCollection [
	notTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> nullTokens [
	^ nullTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> nullTokens: anOrderedCollection [
	nullTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> onTokens [
	^ onTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> onTokens: anOrderedCollection [
	onTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> otherVariables [
	^ #(#value)
]

{ #category : #generated }
MysqlColumnDefinitionNode >> partialToken [
	^ partialToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> partialToken: aSmaCCToken [
	partialToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> primaryToken [
	^ primaryToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> primaryToken: aSmaCCToken [
	primaryToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> refColumnNames [
	^ refColumnNames
]

{ #category : #generated }
MysqlColumnDefinitionNode >> refColumnNames: anOrderedCollection [
	refColumnNames := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> referencesToken [
	^ referencesToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> referencesToken: aSmaCCToken [
	referencesToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> restrictTokens [
	^ restrictTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> restrictTokens: anOrderedCollection [
	restrictTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> secondaryEngineAttribute [
	^ secondaryEngineAttribute
]

{ #category : #generated }
MysqlColumnDefinitionNode >> secondaryEngineAttribute: aSmaCCToken [
	secondaryEngineAttribute := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> secondaryToken [
	^ secondaryToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> secondaryToken: aSmaCCToken [
	secondaryToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> setTokens [
	^ setTokens
]

{ #category : #generated }
MysqlColumnDefinitionNode >> setTokens: anOrderedCollection [
	setTokens := anOrderedCollection
]

{ #category : #generated }
MysqlColumnDefinitionNode >> simpleToken [
	^ simpleToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> simpleToken: aSmaCCToken [
	simpleToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> storageToken [
	^ storageToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> storageToken: aSmaCCToken [
	storageToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> storedToken [
	^ storedToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> storedToken: aSmaCCToken [
	storedToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> tableName [
	^ tableName
]

{ #category : #generated }
MysqlColumnDefinitionNode >> tableName: aSmaCCToken [
	tableName := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> tokenVariables [
	^ #(#columnName #visibleToken #invisibleToken #autoIncrementToken #uniqueToken #primaryToken #commentToken #collateToken #collationName #columnFormatToken #columnFormat #engineAttributeToken #engineAttribute #secondaryToken #secondaryEngineAttribute #storageToken #diskToken #memoryToken #referencesToken #tableName #updateToken #_deleteToken #matchToken #fullToken #partialToken #simpleToken #checkToken #enforcedToken #constraintToken #asToken #virtualToken #storedToken #generatedToken #alwaysToken)
]

{ #category : #generated }
MysqlColumnDefinitionNode >> uniqueToken [
	^ uniqueToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> uniqueToken: aSmaCCToken [
	uniqueToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> updateToken [
	^ updateToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> updateToken: aSmaCCToken [
	updateToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> value [
	^ value
]

{ #category : #generated }
MysqlColumnDefinitionNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]

{ #category : #generated }
MysqlColumnDefinitionNode >> virtualToken [
	^ virtualToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> virtualToken: aSmaCCToken [
	virtualToken := aSmaCCToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> visibleToken [
	^ visibleToken
]

{ #category : #generated }
MysqlColumnDefinitionNode >> visibleToken: aSmaCCToken [
	visibleToken := aSmaCCToken
]
