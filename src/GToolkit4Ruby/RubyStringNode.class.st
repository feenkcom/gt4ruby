Class {
	#name : #RubyStringNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'parts',
		'value',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyStringNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RubyStringNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyStringNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	parts := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyStringNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyStringNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyStringNode >> parts [
	^ parts
]

{ #category : #generated }
RubyStringNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]

{ #category : #generated }
RubyStringNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyStringNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyStringNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RubyStringNode >> value [
	^ value
]

{ #category : #generated }
RubyStringNode >> value: aToken [
	value := aToken
]
