Class {
	#name : #RpRubyStringNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'parts',
		'value',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyStringNode >> acceptVisitor: aVisitor [
	^ aVisitor visitString: self
]

{ #category : #generated }
RpRubyStringNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RpRubyStringNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyStringNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	parts := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyStringNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyStringNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyStringNode >> parts [
	^ parts
]

{ #category : #generated }
RpRubyStringNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]

{ #category : #generated }
RpRubyStringNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyStringNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyStringNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyStringNode >> value [
	^ value
]

{ #category : #generated }
RpRubyStringNode >> value: aToken [
	value := aToken
]
