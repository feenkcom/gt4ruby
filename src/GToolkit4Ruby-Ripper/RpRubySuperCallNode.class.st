Class {
	#name : #RpRubySuperCallNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'superToken',
		'arguments'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubySuperCallNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSuperCall: self
]

{ #category : #generated }
RpRubySuperCallNode >> arguments [
	^ arguments
]

{ #category : #generated }
RpRubySuperCallNode >> arguments: anOrderedCollection [
	self setParent: self arguments to: nil.
	arguments := anOrderedCollection.
	self setParent: self arguments to: self
]

{ #category : #generated }
RpRubySuperCallNode >> initialize [
	super initialize.
	arguments := OrderedCollection new: 2
]

{ #category : #generated }
RpRubySuperCallNode >> otherVariables [
	^ #(arguments)
]

{ #category : #generated }
RpRubySuperCallNode >> superToken [
	^ superToken
]

{ #category : #generated }
RpRubySuperCallNode >> superToken: aToken [
	superToken := aToken
]

{ #category : #generated }
RpRubySuperCallNode >> tokenVariables [
	^ #(superToken)
]
