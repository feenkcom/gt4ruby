Class {
	#name : #RpRubyYieldNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'yield',
		'values',
		'commas'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyYieldNode >> acceptVisitor: aVisitor [
	^ aVisitor visitYield: self
]

{ #category : #generated }
RpRubyYieldNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyYieldNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyYieldNode >> compositeNodeVariables [
	^ #(values)
]

{ #category : #generated }
RpRubyYieldNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyYieldNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	values := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyYieldNode >> tokenVariables [
	^ #(yield)
]

{ #category : #generated }
RpRubyYieldNode >> values [
	^ values
]

{ #category : #generated }
RpRubyYieldNode >> values: anOrderedCollection [
	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]

{ #category : #generated }
RpRubyYieldNode >> yield [
	^ yield
]

{ #category : #generated }
RpRubyYieldNode >> yield: aToken [
	yield := aToken
]
