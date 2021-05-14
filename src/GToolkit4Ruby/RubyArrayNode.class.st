Class {
	#name : #RubyArrayNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'values',
		'commas',
		'leftBracket',
		'rightBracket'
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
	^ #(commas)
]

{ #category : #generated }
RubyArrayNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2
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
