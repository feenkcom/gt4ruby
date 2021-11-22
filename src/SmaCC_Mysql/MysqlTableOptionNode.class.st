Class {
	#name : #MysqlTableOptionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'autoextendSizeToken',
		'value',
		'equals',
		'autoIncrementToken',
		'avgRowLengthToken',
		'characterToken',
		'setToken',
		'charsetToken',
		'defaultToken',
		'checksumToken',
		'collateToken',
		'commentToken',
		'compressionToken',
		'connectionToken',
		'dataToken',
		'directoryToken',
		'indexToken',
		'delayKeyWriteToken',
		'encryptionToken',
		'engineToken',
		'engineAttributeToken',
		'insertMethodToken',
		'keyBlockSizeToken',
		'maxRowsToken',
		'minRowsToken',
		'packKeysToken',
		'passwordToken',
		'rowFormatToken',
		'secondaryToken',
		'statsToken',
		'tableSpaceToken',
		'tablespaceName',
		'storageToken',
		'diskToken',
		'memoryToken',
		'unionToken',
		'leftParen',
		'tableNames',
		'commas',
		'rightParen'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlTableOptionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTableOption: self
]

{ #category : #generated }
MysqlTableOptionNode >> autoIncrementToken [
	^ autoIncrementToken
]

{ #category : #generated }
MysqlTableOptionNode >> autoIncrementToken: aSmaCCToken [
	autoIncrementToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> autoextendSizeToken [
	^ autoextendSizeToken
]

{ #category : #generated }
MysqlTableOptionNode >> autoextendSizeToken: aSmaCCToken [
	autoextendSizeToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> avgRowLengthToken [
	^ avgRowLengthToken
]

{ #category : #generated }
MysqlTableOptionNode >> avgRowLengthToken: aSmaCCToken [
	avgRowLengthToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> characterToken [
	^ characterToken
]

{ #category : #generated }
MysqlTableOptionNode >> characterToken: aSmaCCToken [
	characterToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> charsetToken [
	^ charsetToken
]

{ #category : #generated }
MysqlTableOptionNode >> charsetToken: aSmaCCToken [
	charsetToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> checksumToken [
	^ checksumToken
]

{ #category : #generated }
MysqlTableOptionNode >> checksumToken: aSmaCCToken [
	checksumToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> collateToken [
	^ collateToken
]

{ #category : #generated }
MysqlTableOptionNode >> collateToken: aSmaCCToken [
	collateToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> commas [
	^ commas
]

{ #category : #generated }
MysqlTableOptionNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
MysqlTableOptionNode >> commentToken [
	^ commentToken
]

{ #category : #generated }
MysqlTableOptionNode >> commentToken: aSmaCCToken [
	commentToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> compositeTokenVariables [
	^ #(#tableNames #commas)
]

{ #category : #generated }
MysqlTableOptionNode >> compressionToken [
	^ compressionToken
]

{ #category : #generated }
MysqlTableOptionNode >> compressionToken: aSmaCCToken [
	compressionToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> connectionToken [
	^ connectionToken
]

{ #category : #generated }
MysqlTableOptionNode >> connectionToken: aSmaCCToken [
	connectionToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> dataToken [
	^ dataToken
]

{ #category : #generated }
MysqlTableOptionNode >> dataToken: aSmaCCToken [
	dataToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> defaultToken [
	^ defaultToken
]

{ #category : #generated }
MysqlTableOptionNode >> defaultToken: aSmaCCToken [
	defaultToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> delayKeyWriteToken [
	^ delayKeyWriteToken
]

{ #category : #generated }
MysqlTableOptionNode >> delayKeyWriteToken: aSmaCCToken [
	delayKeyWriteToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> directoryToken [
	^ directoryToken
]

{ #category : #generated }
MysqlTableOptionNode >> directoryToken: aSmaCCToken [
	directoryToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> diskToken [
	^ diskToken
]

{ #category : #generated }
MysqlTableOptionNode >> diskToken: aSmaCCToken [
	diskToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> encryptionToken [
	^ encryptionToken
]

{ #category : #generated }
MysqlTableOptionNode >> encryptionToken: aSmaCCToken [
	encryptionToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> engineAttributeToken [
	^ engineAttributeToken
]

{ #category : #generated }
MysqlTableOptionNode >> engineAttributeToken: aSmaCCToken [
	engineAttributeToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> engineToken [
	^ engineToken
]

{ #category : #generated }
MysqlTableOptionNode >> engineToken: aSmaCCToken [
	engineToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> equals [
	^ equals
]

{ #category : #generated }
MysqlTableOptionNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> indexToken [
	^ indexToken
]

{ #category : #generated }
MysqlTableOptionNode >> indexToken: aSmaCCToken [
	indexToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
MysqlTableOptionNode >> initialize [
	super initialize.
	tableNames := OrderedCollection new: 2.
	commas := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlTableOptionNode >> insertMethodToken [
	^ insertMethodToken
]

{ #category : #generated }
MysqlTableOptionNode >> insertMethodToken: aSmaCCToken [
	insertMethodToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> keyBlockSizeToken [
	^ keyBlockSizeToken
]

{ #category : #generated }
MysqlTableOptionNode >> keyBlockSizeToken: aSmaCCToken [
	keyBlockSizeToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> leftParen [
	^ leftParen
]

{ #category : #generated }
MysqlTableOptionNode >> leftParen: aSmaCCToken [
	leftParen := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> maxRowsToken [
	^ maxRowsToken
]

{ #category : #generated }
MysqlTableOptionNode >> maxRowsToken: aSmaCCToken [
	maxRowsToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> memoryToken [
	^ memoryToken
]

{ #category : #generated }
MysqlTableOptionNode >> memoryToken: aSmaCCToken [
	memoryToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> minRowsToken [
	^ minRowsToken
]

{ #category : #generated }
MysqlTableOptionNode >> minRowsToken: aSmaCCToken [
	minRowsToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> nodeVariables [
	^ #(#tablespaceName)
]

{ #category : #generated }
MysqlTableOptionNode >> otherVariables [
	^ #(#value)
]

{ #category : #generated }
MysqlTableOptionNode >> packKeysToken [
	^ packKeysToken
]

{ #category : #generated }
MysqlTableOptionNode >> packKeysToken: aSmaCCToken [
	packKeysToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> passwordToken [
	^ passwordToken
]

{ #category : #generated }
MysqlTableOptionNode >> passwordToken: aSmaCCToken [
	passwordToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> rightParen [
	^ rightParen
]

{ #category : #generated }
MysqlTableOptionNode >> rightParen: aSmaCCToken [
	rightParen := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> rowFormatToken [
	^ rowFormatToken
]

{ #category : #generated }
MysqlTableOptionNode >> rowFormatToken: aSmaCCToken [
	rowFormatToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> secondaryToken [
	^ secondaryToken
]

{ #category : #generated }
MysqlTableOptionNode >> secondaryToken: aSmaCCToken [
	secondaryToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> setToken [
	^ setToken
]

{ #category : #generated }
MysqlTableOptionNode >> setToken: aSmaCCToken [
	setToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> statsToken [
	^ statsToken
]

{ #category : #generated }
MysqlTableOptionNode >> statsToken: aSmaCCToken [
	statsToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> storageToken [
	^ storageToken
]

{ #category : #generated }
MysqlTableOptionNode >> storageToken: aSmaCCToken [
	storageToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> tableNames [
	^ tableNames
]

{ #category : #generated }
MysqlTableOptionNode >> tableNames: anOrderedCollection [
	tableNames := anOrderedCollection
]

{ #category : #generated }
MysqlTableOptionNode >> tableSpaceToken [
	^ tableSpaceToken
]

{ #category : #generated }
MysqlTableOptionNode >> tableSpaceToken: aSmaCCToken [
	tableSpaceToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> tablespaceName [
	^ tablespaceName
]

{ #category : #generated }
MysqlTableOptionNode >> tablespaceName: aSmaCCErrorNode [
	self tablespaceName notNil ifTrue: [ self tablespaceName parent: nil ].
	tablespaceName := aSmaCCErrorNode.
	self tablespaceName notNil ifTrue: [ self tablespaceName parent: self ]
]

{ #category : #generated }
MysqlTableOptionNode >> tokenVariables [
	^ #(#autoextendSizeToken #equals #autoIncrementToken #avgRowLengthToken #characterToken #setToken #charsetToken #defaultToken #checksumToken #collateToken #commentToken #compressionToken #connectionToken #dataToken #directoryToken #indexToken #delayKeyWriteToken #encryptionToken #engineToken #engineAttributeToken #insertMethodToken #keyBlockSizeToken #maxRowsToken #minRowsToken #packKeysToken #passwordToken #rowFormatToken #secondaryToken #statsToken #tableSpaceToken #storageToken #diskToken #memoryToken #unionToken #leftParen #rightParen)
]

{ #category : #generated }
MysqlTableOptionNode >> unionToken [
	^ unionToken
]

{ #category : #generated }
MysqlTableOptionNode >> unionToken: aSmaCCToken [
	unionToken := aSmaCCToken
]

{ #category : #generated }
MysqlTableOptionNode >> value [
	^ value
]

{ #category : #generated }
MysqlTableOptionNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
