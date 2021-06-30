Class {
	#name : #RubyReturnNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'return',
		'values',
		'commas'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyReturnNode >> acceptVisitor: aVisitor [
	^ aVisitor visitReturn: self
]

{ #category : #generated }
RubyReturnNode >> commas [
	^ commas
]

{ #category : #generated }
RubyReturnNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyReturnNode >> compositeNodeVariables [
	^ #(values)
]

{ #category : #generated }
RubyReturnNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyReturnNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	values := OrderedCollection new: 2
]

{ #category : #generated }
RubyReturnNode >> return [
	^ return
]

{ #category : #generated }
RubyReturnNode >> return: aToken [
	return := aToken
]

{ #category : #generated }
RubyReturnNode >> tokenVariables [
	^ #(return)
]

{ #category : #generated }
RubyReturnNode >> values [
	^ values
]

{ #category : #generated }
RubyReturnNode >> values: anOrderedCollection [
	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]
