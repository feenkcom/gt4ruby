Class {
	#name : #MysqlPartitionDefinitionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'partitionToken',
		'partitionName',
		'engineToken',
		'engineName',
		'equalses',
		'storageToken',
		'commentToken',
		'comment',
		'dataToken',
		'directoryTokens',
		'dataDirectory',
		'indexToken',
		'indexDirectory',
		'maxRowsToken',
		'maxRows',
		'minRowsToken',
		'minRows',
		'tableSpaceToken',
		'tablespaceName',
		'leftParens',
		'definitions',
		'commas',
		'rightParens',
		'valueToken',
		'lessToken',
		'thanToken',
		'values',
		'maxvalueToken',
		'inToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlPartitionDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPartitionDefinition: self
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> commas [
	^ commas
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> comment [
	^ comment
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> comment: aSmaCCToken [
	comment := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> commentToken [
	^ commentToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> commentToken: aSmaCCToken [
	commentToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> compositeNodeVariables [
	^ #(#definitions #values)
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> compositeTokenVariables [
	^ #(#equalses #directoryTokens #leftParens #commas #rightParens)
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> dataDirectory [
	^ dataDirectory
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> dataDirectory: aSmaCCToken [
	dataDirectory := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> dataToken [
	^ dataToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> dataToken: aSmaCCToken [
	dataToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> definitions [
	^ definitions
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> definitions: anOrderedCollection [
	self setParents: self definitions to: nil.
	definitions := anOrderedCollection.
	self setParents: self definitions to: self
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> directoryTokens [
	^ directoryTokens
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> directoryTokens: anOrderedCollection [
	directoryTokens := anOrderedCollection
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> engineName [
	^ engineName
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> engineName: aSmaCCToken [
	engineName := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> engineToken [
	^ engineToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> engineToken: aSmaCCToken [
	engineToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> equalses [
	^ equalses
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> equalses: anOrderedCollection [
	equalses := anOrderedCollection
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> inToken [
	^ inToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> inToken: aSmaCCToken [
	inToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> indexDirectory [
	^ indexDirectory
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> indexDirectory: aSmaCCToken [
	indexDirectory := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> indexToken [
	^ indexToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> indexToken: aSmaCCToken [
	indexToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlPartitionDefinitionNode >> initialize [
	super initialize.
	equalses := OrderedCollection new: 2.
	directoryTokens := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	definitions := OrderedCollection new: 2.
	commas := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
	values := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> lessToken [
	^ lessToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> lessToken: aSmaCCToken [
	lessToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> maxRows [
	^ maxRows
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> maxRows: aSmaCCToken [
	maxRows := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> maxRowsToken [
	^ maxRowsToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> maxRowsToken: aSmaCCToken [
	maxRowsToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> maxvalueToken [
	^ maxvalueToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> maxvalueToken: aSmaCCToken [
	maxvalueToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> minRows [
	^ minRows
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> minRows: aSmaCCToken [
	minRows := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> minRowsToken [
	^ minRowsToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> minRowsToken: aSmaCCToken [
	minRowsToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> nodeVariables [
	^ #(#partitionName #tablespaceName)
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> partitionName [
	^ partitionName
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> partitionName: aSmaCCErrorNode [
	self partitionName notNil
		ifTrue: [ self partitionName parent: nil ].
	partitionName := aSmaCCErrorNode.
	self partitionName notNil
		ifTrue: [ self partitionName parent: self ]
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> partitionToken [
	^ partitionToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> partitionToken: aSmaCCToken [
	partitionToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> storageToken [
	^ storageToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> storageToken: aSmaCCToken [
	storageToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> tableSpaceToken [
	^ tableSpaceToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> tableSpaceToken: aSmaCCToken [
	tableSpaceToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> tablespaceName [
	^ tablespaceName
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> tablespaceName: aSmaCCErrorNode [
	self tablespaceName notNil
		ifTrue: [ self tablespaceName parent: nil ].
	tablespaceName := aSmaCCErrorNode.
	self tablespaceName notNil
		ifTrue: [ self tablespaceName parent: self ]
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> thanToken [
	^ thanToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> thanToken: aSmaCCToken [
	thanToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> tokenVariables [
	^ #(#partitionToken #engineToken #engineName #storageToken #commentToken #comment #dataToken #dataDirectory #indexToken #indexDirectory #maxRowsToken #maxRows #minRowsToken #minRows #tableSpaceToken #valueToken #lessToken #thanToken #maxvalueToken #inToken)
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> valueToken [
	^ valueToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> valueToken: aSmaCCToken [
	valueToken := aSmaCCToken
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> values [
	^ values
]

{ #category : #generated }
MysqlPartitionDefinitionNode >> values: anOrderedCollection [
	self setParents: self values to: nil.
	values := anOrderedCollection.
	self setParents: self values to: self
]
