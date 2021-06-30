Class {
	#name : #MysqlProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
