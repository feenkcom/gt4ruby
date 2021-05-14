Class {
	#name : #RubyStatementBlockNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyStatementBlockNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyStatementBlockNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyStatementBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RubyStatementBlockNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]
