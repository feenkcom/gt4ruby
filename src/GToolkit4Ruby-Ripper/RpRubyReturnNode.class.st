Class {
	#name : #RpRubyReturnNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'return',
		'values',
		'commas'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyReturnNode >> acceptVisitor: aVisitor [
	^ aVisitor visitReturn: self
]

{ #category : #generated }
RpRubyReturnNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyReturnNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyReturnNode >> compositeNodeVariables [
	^ #(values)
]

{ #category : #generated }
RpRubyReturnNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyReturnNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	values := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyReturnNode >> return [
	^ return
]

{ #category : #generated }
RpRubyReturnNode >> return: aToken [
	return := aToken
]

{ #category : #generated }
RpRubyReturnNode >> tokenVariables [
	^ #(return)
]

{ #category : #generated }
RpRubyReturnNode >> values [
	^ values
]

{ #category : #generated }
RpRubyReturnNode >> values: anOrderedCollection [
	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]
