Class {
	#name : #MysqlDataTypeNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'typeName',
		'characterToken',
		'setToken',
		'equals',
		'charsetName',
		'collateToken',
		'collationName',
		'charsetToken',
		'unsignedToken',
		'leftParen',
		'length',
		'rightParen',
		'comma',
		'precision'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlDataTypeNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDataType: self
]

{ #category : #generated }
MysqlDataTypeNode >> characterToken [
	^ characterToken
]

{ #category : #generated }
MysqlDataTypeNode >> characterToken: aSmaCCToken [
	characterToken := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> charsetName [
	^ charsetName
]

{ #category : #generated }
MysqlDataTypeNode >> charsetName: aSmaCCToken [
	charsetName := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> charsetToken [
	^ charsetToken
]

{ #category : #generated }
MysqlDataTypeNode >> charsetToken: aSmaCCToken [
	charsetToken := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> collateToken [
	^ collateToken
]

{ #category : #generated }
MysqlDataTypeNode >> collateToken: aSmaCCToken [
	collateToken := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> collationName [
	^ collationName
]

{ #category : #generated }
MysqlDataTypeNode >> collationName: aSmaCCToken [
	collationName := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> comma [
	^ comma
]

{ #category : #generated }
MysqlDataTypeNode >> comma: aSmaCCToken [
	comma := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> equals [
	^ equals
]

{ #category : #generated }
MysqlDataTypeNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> leftParen [
	^ leftParen
]

{ #category : #generated }
MysqlDataTypeNode >> leftParen: aSmaCCToken [
	leftParen := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> length [
	^ length
]

{ #category : #generated }
MysqlDataTypeNode >> length: aSmaCCToken [
	length := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> precision [
	^ precision
]

{ #category : #generated }
MysqlDataTypeNode >> precision: aSmaCCToken [
	precision := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> rightParen [
	^ rightParen
]

{ #category : #generated }
MysqlDataTypeNode >> rightParen: aSmaCCToken [
	rightParen := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> setToken [
	^ setToken
]

{ #category : #generated }
MysqlDataTypeNode >> setToken: aSmaCCToken [
	setToken := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> tokenVariables [
	^ #(#typeName #characterToken #setToken #equals #charsetName #collateToken #collationName #charsetToken #unsignedToken #leftParen #length #rightParen #comma #precision)
]

{ #category : #generated }
MysqlDataTypeNode >> typeName [
	^ typeName
]

{ #category : #generated }
MysqlDataTypeNode >> typeName: aSmaCCToken [
	typeName := aSmaCCToken
]

{ #category : #generated }
MysqlDataTypeNode >> unsignedToken [
	^ unsignedToken
]

{ #category : #generated }
MysqlDataTypeNode >> unsignedToken: aSmaCCToken [
	unsignedToken := aSmaCCToken
]
