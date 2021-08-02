Class {
	#name : #RpRubyVariableNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitVariable: self
]

{ #category : #generated }
RpRubyVariableNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyVariableNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyVariableNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyVariableNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyVariableNode >> name [
	^ name
]

{ #category : #generated }
RpRubyVariableNode >> name: anObject [
	self setParent: self name to: nil.
	name := anObject.
	self setParent: self name to: self
]

{ #category : #generated }
RpRubyVariableNode >> otherVariables [
	^ #(name)
]

{ #category : #generated }
RpRubyVariableNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyVariableNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #accessing }
RpRubyVariableNode >> variableName [
	^ name source
]
