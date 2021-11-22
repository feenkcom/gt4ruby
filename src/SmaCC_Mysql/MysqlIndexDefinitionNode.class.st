Class {
	#name : #MysqlIndexDefinitionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'indexToken',
		'leftParens',
		'refColumnNames',
		'directions',
		'lengths',
		'rightParens',
		'exprs',
		'commas',
		'option',
		'usingToken',
		'btreeToken',
		'hashToken',
		'indexName',
		'keyToken',
		'fulltextToken',
		'spatialToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlIndexDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitIndexDefinition: self
]

{ #category : #generated }
MysqlIndexDefinitionNode >> btreeToken [
	^ btreeToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> btreeToken: aSmaCCToken [
	btreeToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> commas [
	^ commas
]

{ #category : #generated }
MysqlIndexDefinitionNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
MysqlIndexDefinitionNode >> compositeNodeVariables [
	^ #(#exprs)
]

{ #category : #generated }
MysqlIndexDefinitionNode >> compositeTokenVariables [
	^ #(#leftParens #refColumnNames #directions #lengths #rightParens #commas)
]

{ #category : #generated }
MysqlIndexDefinitionNode >> directions [
	^ directions
]

{ #category : #generated }
MysqlIndexDefinitionNode >> directions: anOrderedCollection [
	directions := anOrderedCollection
]

{ #category : #generated }
MysqlIndexDefinitionNode >> exprs [
	^ exprs
]

{ #category : #generated }
MysqlIndexDefinitionNode >> exprs: anOrderedCollection [
	self setParents: self exprs to: nil.
	exprs := anOrderedCollection.
	self setParents: self exprs to: self
]

{ #category : #generated }
MysqlIndexDefinitionNode >> fulltextToken [
	^ fulltextToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> fulltextToken: aSmaCCToken [
	fulltextToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> hashToken [
	^ hashToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> hashToken: aSmaCCToken [
	hashToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> indexName [
	^ indexName
]

{ #category : #generated }
MysqlIndexDefinitionNode >> indexName: aSmaCCToken [
	indexName := aSmaCCToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> indexToken [
	^ indexToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> indexToken: aSmaCCToken [
	indexToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlIndexDefinitionNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	refColumnNames := OrderedCollection new: 2.
	directions := OrderedCollection new: 2.
	lengths := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
	exprs := OrderedCollection new: 2.
	commas := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlIndexDefinitionNode >> keyToken [
	^ keyToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> keyToken: aSmaCCToken [
	keyToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
MysqlIndexDefinitionNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
MysqlIndexDefinitionNode >> lengths [
	^ lengths
]

{ #category : #generated }
MysqlIndexDefinitionNode >> lengths: anOrderedCollection [
	lengths := anOrderedCollection
]

{ #category : #generated }
MysqlIndexDefinitionNode >> nodeVariables [
	^ #(#option)
]

{ #category : #generated }
MysqlIndexDefinitionNode >> option [
	^ option
]

{ #category : #generated }
MysqlIndexDefinitionNode >> option: aMysqlIndexOptionNode [
	self option notNil ifTrue: [ self option parent: nil ].
	option := aMysqlIndexOptionNode.
	self option notNil ifTrue: [ self option parent: self ]
]

{ #category : #generated }
MysqlIndexDefinitionNode >> refColumnNames [
	^ refColumnNames
]

{ #category : #generated }
MysqlIndexDefinitionNode >> refColumnNames: anOrderedCollection [
	refColumnNames := anOrderedCollection
]

{ #category : #generated }
MysqlIndexDefinitionNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
MysqlIndexDefinitionNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
MysqlIndexDefinitionNode >> spatialToken [
	^ spatialToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> spatialToken: aSmaCCToken [
	spatialToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> tokenVariables [
	^ #(#indexToken #usingToken #btreeToken #hashToken #indexName #keyToken #fulltextToken #spatialToken)
]

{ #category : #generated }
MysqlIndexDefinitionNode >> usingToken [
	^ usingToken
]

{ #category : #generated }
MysqlIndexDefinitionNode >> usingToken: aSmaCCToken [
	usingToken := aSmaCCToken
]
