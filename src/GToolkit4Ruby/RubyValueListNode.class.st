Class {
	#name : #RubyValueListNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'values',
		'commas'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyValueListNode >> acceptVisitor: aVisitor [
	^ aVisitor visitValueList: self
]

{ #category : #generated }
RubyValueListNode >> commas [
	^ commas
]

{ #category : #generated }
RubyValueListNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyValueListNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyValueListNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2
]

{ #category : #generated }
RubyValueListNode >> otherVariables [
	^ #(values)
]

{ #category : #generated }
RubyValueListNode >> values [
	^ values
]

{ #category : #generated }
RubyValueListNode >> values: anObject [
	self setParent: self values to: nil.
	values := anObject.
	self setParent: self values to: self
]
