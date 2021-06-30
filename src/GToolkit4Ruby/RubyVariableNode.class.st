Class {
	#name : #RubyVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitVariable: self
]

{ #category : #generated }
RubyVariableNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyVariableNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyVariableNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyVariableNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyVariableNode >> name [
	^ name
]

{ #category : #generated }
RubyVariableNode >> name: anObject [
	self setParent: self name to: nil.
	name := anObject.
	self setParent: self name to: self
]

{ #category : #generated }
RubyVariableNode >> otherVariables [
	^ #(name)
]

{ #category : #generated }
RubyVariableNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyVariableNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]
