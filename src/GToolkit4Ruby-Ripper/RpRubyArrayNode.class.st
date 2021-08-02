Class {
	#name : #RpRubyArrayNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'values',
		'commas',
		'leftBracket',
		'rightBracket',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyArrayNode >> acceptVisitor: aVisitor [
	^ aVisitor visitArray: self
]

{ #category : #generated }
RpRubyArrayNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyArrayNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyArrayNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RpRubyArrayNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyArrayNode >> leftBracket [
	^ leftBracket
]

{ #category : #generated }
RpRubyArrayNode >> leftBracket: aToken [
	leftBracket := aToken
]

{ #category : #generated }
RpRubyArrayNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyArrayNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyArrayNode >> otherVariables [
	^ #(values)
]

{ #category : #generated }
RpRubyArrayNode >> rightBracket [
	^ rightBracket
]

{ #category : #generated }
RpRubyArrayNode >> rightBracket: aToken [
	rightBracket := aToken
]

{ #category : #generated }
RpRubyArrayNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyArrayNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyArrayNode >> tokenVariables [
	^ #(leftBracket rightBracket)
]

{ #category : #generated }
RpRubyArrayNode >> values [
	^ values
]

{ #category : #generated }
RpRubyArrayNode >> values: anObject [
	self setParent: self values to: nil.
	values := anObject.
	self setParent: self values to: self
]
