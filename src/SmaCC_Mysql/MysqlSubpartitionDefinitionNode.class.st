Class {
	#name : #MysqlSubpartitionDefinitionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'subpartitionToken',
		'subpartion',
		'dataToken',
		'directoryTokens',
		'dataDirectory',
		'equalses',
		'indexToken',
		'indexDirectory',
		'maxRowsToken',
		'maxRows',
		'minRowsToken',
		'minRows',
		'tableSpaceToken',
		'tablespaceName',
		'commentToken',
		'comment',
		'engineToken',
		'engineName',
		'storageToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSubpartitionDefinition: self
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> comment [
	^ comment
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> comment: aSmaCCToken [
	comment := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> commentToken [
	^ commentToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> commentToken: aSmaCCToken [
	commentToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> compositeTokenVariables [
	^ #(#directoryTokens #equalses)
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> dataDirectory [
	^ dataDirectory
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> dataDirectory: aSmaCCToken [
	dataDirectory := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> dataToken [
	^ dataToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> dataToken: aSmaCCToken [
	dataToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> directoryTokens [
	^ directoryTokens
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> directoryTokens: anOrderedCollection [
	directoryTokens := anOrderedCollection
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> engineName [
	^ engineName
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> engineName: aSmaCCToken [
	engineName := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> engineToken [
	^ engineToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> engineToken: aSmaCCToken [
	engineToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> equalses [
	^ equalses
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> equalses: anOrderedCollection [
	equalses := anOrderedCollection
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> indexDirectory [
	^ indexDirectory
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> indexDirectory: aSmaCCToken [
	indexDirectory := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> indexToken [
	^ indexToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> indexToken: aSmaCCToken [
	indexToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlSubpartitionDefinitionNode >> initialize [
	super initialize.
	directoryTokens := OrderedCollection new: 2.
	equalses := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> maxRows [
	^ maxRows
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> maxRows: aSmaCCToken [
	maxRows := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> maxRowsToken [
	^ maxRowsToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> maxRowsToken: aSmaCCToken [
	maxRowsToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> minRows [
	^ minRows
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> minRows: aSmaCCToken [
	minRows := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> minRowsToken [
	^ minRowsToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> minRowsToken: aSmaCCToken [
	minRowsToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> nodeVariables [
	^ #(#subpartion #tablespaceName)
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> storageToken [
	^ storageToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> storageToken: aSmaCCToken [
	storageToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> subpartion [
	^ subpartion
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> subpartion: aSmaCCErrorNode [
	self subpartion notNil
		ifTrue: [ self subpartion parent: nil ].
	subpartion := aSmaCCErrorNode.
	self subpartion notNil
		ifTrue: [ self subpartion parent: self ]
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> subpartitionToken [
	^ subpartitionToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> subpartitionToken: aSmaCCToken [
	subpartitionToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> tableSpaceToken [
	^ tableSpaceToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> tableSpaceToken: aSmaCCToken [
	tableSpaceToken := aSmaCCToken
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> tablespaceName [
	^ tablespaceName
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> tablespaceName: aSmaCCErrorNode [
	self tablespaceName notNil
		ifTrue: [ self tablespaceName parent: nil ].
	tablespaceName := aSmaCCErrorNode.
	self tablespaceName notNil
		ifTrue: [ self tablespaceName parent: self ]
]

{ #category : #generated }
MysqlSubpartitionDefinitionNode >> tokenVariables [
	^ #(#subpartitionToken #dataToken #dataDirectory #indexToken #indexDirectory #maxRowsToken #maxRows #minRowsToken #minRows #tableSpaceToken #commentToken #comment #engineToken #engineName #storageToken)
]
