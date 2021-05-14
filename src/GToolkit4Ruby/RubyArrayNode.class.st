Class {
	#name : #RubyArrayNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'values',
		'commas',
		'leftBracket',
		'rightBracket',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyArrayNode >> commas [
	^ commas
]

{ #category : #generated }
RubyArrayNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyArrayNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RubyArrayNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyArrayNode >> leftBracket [
	^ leftBracket
]

{ #category : #generated }
RubyArrayNode >> leftBracket: aToken [
	leftBracket := aToken
]

{ #category : #generated }
RubyArrayNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyArrayNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyArrayNode >> otherVariables [
	^ #(values)
]

{ #category : #generated }
RubyArrayNode >> rightBracket [
	^ rightBracket
]

{ #category : #generated }
RubyArrayNode >> rightBracket: aToken [
	rightBracket := aToken
]

{ #category : #generated }
RubyArrayNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyArrayNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyArrayNode >> tokenVariables [
	^ #(leftBracket rightBracket)
]

{ #category : #generated }
RubyArrayNode >> values [
	^ values
]

{ #category : #generated }
RubyArrayNode >> values: anObject [
	self setParent: self values to: nil.
	values := anObject.
	self setParent: self values to: self
]
