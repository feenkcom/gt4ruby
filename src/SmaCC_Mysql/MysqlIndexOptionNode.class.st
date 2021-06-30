Class {
	#name : #MysqlIndexOptionNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'keyBlockSizeToken',
		'value',
		'equals',
		'usingToken',
		'btreeToken',
		'hashToken',
		'withToken',
		'parserToken',
		'commentToken',
		'visibleToken',
		'invisibleToken',
		'engineAttributeToken',
		'secondaryToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlIndexOptionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitIndexOption: self
]

{ #category : #generated }
MysqlIndexOptionNode >> btreeToken [
	^ btreeToken
]

{ #category : #generated }
MysqlIndexOptionNode >> btreeToken: aSmaCCToken [
	btreeToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> commentToken [
	^ commentToken
]

{ #category : #generated }
MysqlIndexOptionNode >> commentToken: aSmaCCToken [
	commentToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> engineAttributeToken [
	^ engineAttributeToken
]

{ #category : #generated }
MysqlIndexOptionNode >> engineAttributeToken: aSmaCCToken [
	engineAttributeToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> equals [
	^ equals
]

{ #category : #generated }
MysqlIndexOptionNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> hashToken [
	^ hashToken
]

{ #category : #generated }
MysqlIndexOptionNode >> hashToken: aSmaCCToken [
	hashToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> invisibleToken [
	^ invisibleToken
]

{ #category : #generated }
MysqlIndexOptionNode >> invisibleToken: aSmaCCToken [
	invisibleToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> keyBlockSizeToken [
	^ keyBlockSizeToken
]

{ #category : #generated }
MysqlIndexOptionNode >> keyBlockSizeToken: aSmaCCToken [
	keyBlockSizeToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> otherVariables [
	^ #(#value)
]

{ #category : #generated }
MysqlIndexOptionNode >> parserToken [
	^ parserToken
]

{ #category : #generated }
MysqlIndexOptionNode >> parserToken: aSmaCCToken [
	parserToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> secondaryToken [
	^ secondaryToken
]

{ #category : #generated }
MysqlIndexOptionNode >> secondaryToken: aSmaCCToken [
	secondaryToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> tokenVariables [
	^ #(#keyBlockSizeToken #equals #usingToken #btreeToken #hashToken #withToken #parserToken #commentToken #visibleToken #invisibleToken #engineAttributeToken #secondaryToken)
]

{ #category : #generated }
MysqlIndexOptionNode >> usingToken [
	^ usingToken
]

{ #category : #generated }
MysqlIndexOptionNode >> usingToken: aSmaCCToken [
	usingToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> value [
	^ value
]

{ #category : #generated }
MysqlIndexOptionNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]

{ #category : #generated }
MysqlIndexOptionNode >> visibleToken [
	^ visibleToken
]

{ #category : #generated }
MysqlIndexOptionNode >> visibleToken: aSmaCCToken [
	visibleToken := aSmaCCToken
]

{ #category : #generated }
MysqlIndexOptionNode >> withToken [
	^ withToken
]

{ #category : #generated }
MysqlIndexOptionNode >> withToken: aSmaCCToken [
	withToken := aSmaCCToken
]
