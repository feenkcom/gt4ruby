Class {
	#name : #RubySuperCallNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'superToken',
		'arguments'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubySuperCallNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSuperCall: self
]

{ #category : #generated }
RubySuperCallNode >> arguments [
	^ arguments
]

{ #category : #generated }
RubySuperCallNode >> arguments: anOrderedCollection [
	self setParent: self arguments to: nil.
	arguments := anOrderedCollection.
	self setParent: self arguments to: self
]

{ #category : #generated }
RubySuperCallNode >> initialize [
	super initialize.
	arguments := OrderedCollection new: 2
]

{ #category : #generated }
RubySuperCallNode >> otherVariables [
	^ #(arguments)
]

{ #category : #generated }
RubySuperCallNode >> superToken [
	^ superToken
]

{ #category : #generated }
RubySuperCallNode >> superToken: aToken [
	superToken := aToken
]

{ #category : #generated }
RubySuperCallNode >> tokenVariables [
	^ #(superToken)
]
