Class {
	#name : #RubyParamsNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variables',
		'right',
		'left',
		'commas',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyParamsNode >> acceptVisitor: aVisitor [
	^ aVisitor visitParams: self
]

{ #category : #generated }
RubyParamsNode >> commas [
	^ commas
]

{ #category : #generated }
RubyParamsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyParamsNode >> compositeNodeVariables [
	^ #(variables)
]

{ #category : #generated }
RubyParamsNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RubyParamsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyParamsNode >> left [
	^ left
]

{ #category : #generated }
RubyParamsNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyParamsNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyParamsNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyParamsNode >> right [
	^ right
]

{ #category : #generated }
RubyParamsNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyParamsNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyParamsNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyParamsNode >> tokenVariables [
	^ #(left right)
]

{ #category : #generated }
RubyParamsNode >> variables [
	^ variables
]

{ #category : #generated }
RubyParamsNode >> variables: anOrderedCollection [
	self setParent: self variables to: nil.
	variables := anOrderedCollection.
	self setParent: self variables to: self
]
