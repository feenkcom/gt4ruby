Class {
	#name : #MysqlFileNode,
	#superclass : #MysqlProgramNode,
	#instVars : [
		'statements',
		'semicolons'
	],
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlFileNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitFile: self
]

{ #category : #generated }
MysqlFileNode >> compositeNodeVariables [
	^ #(#statements)
]

{ #category : #generated }
MysqlFileNode >> compositeTokenVariables [
	^ #(#semicolons)
]

{ #category : #'generated-initialize-release' }
MysqlFileNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2.
	semicolons := OrderedCollection new: 2.
]

{ #category : #generated }
MysqlFileNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
MysqlFileNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
MysqlFileNode >> statements [
	^ statements
]

{ #category : #generated }
MysqlFileNode >> statements: anOrderedCollection [
	self setParents: self statements to: nil.
	statements := anOrderedCollection.
	self setParents: self statements to: self
]
