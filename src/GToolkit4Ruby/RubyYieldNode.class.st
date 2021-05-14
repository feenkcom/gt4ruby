Class {
	#name : #RubyYieldNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'yield',
		'values',
		'commas'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyYieldNode >> commas [
	^ commas
]

{ #category : #generated }
RubyYieldNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyYieldNode >> compositeNodeVariables [
	^ #(values)
]

{ #category : #generated }
RubyYieldNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyYieldNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	values := OrderedCollection new: 2
]

{ #category : #generated }
RubyYieldNode >> tokenVariables [
	^ #(yield)
]

{ #category : #generated }
RubyYieldNode >> values [
	^ values
]

{ #category : #generated }
RubyYieldNode >> values: anOrderedCollection [
	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]

{ #category : #generated }
RubyYieldNode >> yield [
	^ yield
]

{ #category : #generated }
RubyYieldNode >> yield: aToken [
	yield := aToken
]
