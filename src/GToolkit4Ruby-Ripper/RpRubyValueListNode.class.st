Class {
	#name : #RpRubyValueListNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'values',
		'commas'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyValueListNode >> acceptVisitor: aVisitor [
	^ aVisitor visitValueList: self
]

{ #category : #generated }
RpRubyValueListNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyValueListNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyValueListNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyValueListNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyValueListNode >> otherVariables [
	^ #(values)
]

{ #category : #generated }
RpRubyValueListNode >> values [
	^ values
]

{ #category : #generated }
RpRubyValueListNode >> values: anObject [
	self setParent: self values to: nil.
	values := anObject.
	self setParent: self values to: self
]
