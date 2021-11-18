Class {
	#name : #MysqlCreateTableNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'createToken',
		'tableToken',
		'tableName',
		'leftParens',
		'definitions',
		'commas',
		'rightParens',
		'partitionToken',
		'byTokens',
		'hashToken',
		'_hash',
		'linearToken',
		'keyToken',
		'algorithmToken',
		'equals',
		'value',
		'columnNames',
		'rangeToken',
		'range',
		'columnsToken',
		'listToken',
		'list',
		'partitionsToken',
		'partitions',
		'subpartitionToken',
		'subpartitionsToken',
		'subpartitions',
		'options',
		'ifToken',
		'notToken',
		'existsToken',
		'temporaryToken',
		'ignoreToken',
		'replaceToken',
		'asToken',
		'query',
		'likeToken',
		'likeTableName'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlCreateTableNode >> _hash [
	^ _hash
]

{ #category : #generated }
MysqlCreateTableNode >> _hash: aSmaCCErrorNode [
	self _hash notNil ifTrue: [ self _hash parent: nil ].
	_hash := aSmaCCErrorNode.
	self _hash notNil ifTrue: [ self _hash parent: self ]
]

{ #category : #generated }
MysqlCreateTableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCreateTable: self
]

{ #category : #generated }
MysqlCreateTableNode >> algorithmToken [
	^ algorithmToken
]

{ #category : #generated }
MysqlCreateTableNode >> algorithmToken: aSmaCCToken [
	algorithmToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> asToken [
	^ asToken
]

{ #category : #generated }
MysqlCreateTableNode >> asToken: aSmaCCToken [
	asToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> byTokens [
	^ byTokens
]

{ #category : #generated }
MysqlCreateTableNode >> byTokens: anOrderedCollection [
	byTokens := anOrderedCollection
]

{ #category : #generated }
MysqlCreateTableNode >> columnNames [
	^ columnNames
]

{ #category : #generated }
MysqlCreateTableNode >> columnNames: anOrderedCollection [
	columnNames := anOrderedCollection
]

{ #category : #generated }
MysqlCreateTableNode >> columnsToken [
	^ columnsToken
]

{ #category : #generated }
MysqlCreateTableNode >> columnsToken: aSmaCCToken [
	columnsToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> commas [
	^ commas
]

{ #category : #generated }
MysqlCreateTableNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
MysqlCreateTableNode >> compositeNodeVariables [
	^ #(#definitions #options)
]

{ #category : #generated }
MysqlCreateTableNode >> compositeTokenVariables [
	^ #(#leftParens #commas #rightParens #byTokens #columnNames)
]

{ #category : #generated }
MysqlCreateTableNode >> createToken [
	^ createToken
]

{ #category : #generated }
MysqlCreateTableNode >> createToken: aSmaCCToken [
	createToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> definitions [
	^ definitions
]

{ #category : #generated }
MysqlCreateTableNode >> definitions: anOrderedCollection [
	self setParents: self definitions to: nil.
	definitions := anOrderedCollection.
	self setParents: self definitions to: self
]

{ #category : #generated }
MysqlCreateTableNode >> equals [
	^ equals
]

{ #category : #generated }
MysqlCreateTableNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> existsToken [
	^ existsToken
]

{ #category : #generated }
MysqlCreateTableNode >> existsToken: aSmaCCToken [
	existsToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> hashToken [
	^ hashToken
]

{ #category : #generated }
MysqlCreateTableNode >> hashToken: aSmaCCToken [
	hashToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
MysqlCreateTableNode >> ifToken: aSmaCCToken [
	ifToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> ignoreToken [
	^ ignoreToken
]

{ #category : #generated }
MysqlCreateTableNode >> ignoreToken: aSmaCCToken [
	ignoreToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlCreateTableNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	definitions := OrderedCollection new: 2.
	commas := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
	byTokens := OrderedCollection new: 2.
	columnNames := OrderedCollection new: 2.
	options := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlCreateTableNode >> keyToken [
	^ keyToken
]

{ #category : #generated }
MysqlCreateTableNode >> keyToken: aSmaCCToken [
	keyToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
MysqlCreateTableNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
MysqlCreateTableNode >> likeTableName [
	^ likeTableName
]

{ #category : #generated }
MysqlCreateTableNode >> likeTableName: aSmaCCToken [
	likeTableName := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> likeToken [
	^ likeToken
]

{ #category : #generated }
MysqlCreateTableNode >> likeToken: aSmaCCToken [
	likeToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> linearToken [
	^ linearToken
]

{ #category : #generated }
MysqlCreateTableNode >> linearToken: aSmaCCToken [
	linearToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> list [
	^ list
]

{ #category : #generated }
MysqlCreateTableNode >> list: aSmaCCErrorNode [
	self list notNil ifTrue: [ self list parent: nil ].
	list := aSmaCCErrorNode.
	self list notNil ifTrue: [ self list parent: self ]
]

{ #category : #generated }
MysqlCreateTableNode >> listToken [
	^ listToken
]

{ #category : #generated }
MysqlCreateTableNode >> listToken: aSmaCCToken [
	listToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> nodeVariables [
	^ #(#_hash #range #list #query)
]

{ #category : #generated }
MysqlCreateTableNode >> notToken [
	^ notToken
]

{ #category : #generated }
MysqlCreateTableNode >> notToken: aSmaCCToken [
	notToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> options [
	^ options
]

{ #category : #generated }
MysqlCreateTableNode >> options: anOrderedCollection [
	self setParents: self options to: nil.
	options := anOrderedCollection.
	self setParents: self options to: self
]

{ #category : #generated }
MysqlCreateTableNode >> partitionToken [
	^ partitionToken
]

{ #category : #generated }
MysqlCreateTableNode >> partitionToken: aSmaCCToken [
	partitionToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> partitions [
	^ partitions
]

{ #category : #generated }
MysqlCreateTableNode >> partitions: aSmaCCToken [
	partitions := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> partitionsToken [
	^ partitionsToken
]

{ #category : #generated }
MysqlCreateTableNode >> partitionsToken: aSmaCCToken [
	partitionsToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> query [
	^ query
]

{ #category : #generated }
MysqlCreateTableNode >> query: aSmaCCErrorNode [
	self query notNil ifTrue: [ self query parent: nil ].
	query := aSmaCCErrorNode.
	self query notNil ifTrue: [ self query parent: self ]
]

{ #category : #generated }
MysqlCreateTableNode >> range [
	^ range
]

{ #category : #generated }
MysqlCreateTableNode >> range: aSmaCCErrorNode [
	self range notNil ifTrue: [ self range parent: nil ].
	range := aSmaCCErrorNode.
	self range notNil ifTrue: [ self range parent: self ]
]

{ #category : #generated }
MysqlCreateTableNode >> rangeToken [
	^ rangeToken
]

{ #category : #generated }
MysqlCreateTableNode >> rangeToken: aSmaCCToken [
	rangeToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> replaceToken [
	^ replaceToken
]

{ #category : #generated }
MysqlCreateTableNode >> replaceToken: aSmaCCToken [
	replaceToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
MysqlCreateTableNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
MysqlCreateTableNode >> subpartitionToken [
	^ subpartitionToken
]

{ #category : #generated }
MysqlCreateTableNode >> subpartitionToken: aSmaCCToken [
	subpartitionToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> subpartitions [
	^ subpartitions
]

{ #category : #generated }
MysqlCreateTableNode >> subpartitions: aSmaCCToken [
	subpartitions := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> subpartitionsToken [
	^ subpartitionsToken
]

{ #category : #generated }
MysqlCreateTableNode >> subpartitionsToken: aSmaCCToken [
	subpartitionsToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> tableName [
	^ tableName
]

{ #category : #generated }
MysqlCreateTableNode >> tableName: aSmaCCToken [
	tableName := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> tableToken [
	^ tableToken
]

{ #category : #generated }
MysqlCreateTableNode >> tableToken: aSmaCCToken [
	tableToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> temporaryToken [
	^ temporaryToken
]

{ #category : #generated }
MysqlCreateTableNode >> temporaryToken: aSmaCCToken [
	temporaryToken := aSmaCCToken
]

{ #category : #generated }
MysqlCreateTableNode >> tokenVariables [
	^ #(#createToken #tableToken #tableName #partitionToken #hashToken #linearToken #keyToken #algorithmToken #equals #value #rangeToken #columnsToken #listToken #partitionsToken #partitions #subpartitionToken #subpartitionsToken #subpartitions #ifToken #notToken #existsToken #temporaryToken #ignoreToken #replaceToken #asToken #likeToken #likeTableName)
]

{ #category : #generated }
MysqlCreateTableNode >> value [
	^ value
]

{ #category : #generated }
MysqlCreateTableNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
