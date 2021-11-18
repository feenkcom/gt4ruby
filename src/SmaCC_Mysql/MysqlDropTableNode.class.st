Class {
	#name : #MysqlDropTableNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'dropToken',
		'tableToken',
		'tableName',
		'ifToken',
		'existsToken'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlDropTableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDropTable: self
]

{ #category : #generated }
MysqlDropTableNode >> dropToken [
	^ dropToken
]

{ #category : #generated }
MysqlDropTableNode >> dropToken: aSmaCCToken [
	dropToken := aSmaCCToken
]

{ #category : #generated }
MysqlDropTableNode >> existsToken [
	^ existsToken
]

{ #category : #generated }
MysqlDropTableNode >> existsToken: aSmaCCToken [
	existsToken := aSmaCCToken
]

{ #category : #generated }
MysqlDropTableNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
MysqlDropTableNode >> ifToken: aSmaCCToken [
	ifToken := aSmaCCToken
]

{ #category : #generated }
MysqlDropTableNode >> tableName [
	^ tableName
]

{ #category : #generated }
MysqlDropTableNode >> tableName: aSmaCCToken [
	tableName := aSmaCCToken
]

{ #category : #generated }
MysqlDropTableNode >> tableToken [
	^ tableToken
]

{ #category : #generated }
MysqlDropTableNode >> tableToken: aSmaCCToken [
	tableToken := aSmaCCToken
]

{ #category : #generated }
MysqlDropTableNode >> tokenVariables [
	^ #(#dropToken #tableToken #tableName #ifToken #existsToken)
]
