Class {
	#name : #RpRubyParamsNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'variables',
		'right',
		'left',
		'commas',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyParamsNode >> acceptVisitor: aVisitor [
	^ aVisitor visitParams: self
]

{ #category : #generated }
RpRubyParamsNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyParamsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyParamsNode >> compositeNodeVariables [
	^ #(variables)
]

{ #category : #generated }
RpRubyParamsNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RpRubyParamsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyParamsNode >> left [
	^ left
]

{ #category : #generated }
RpRubyParamsNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyParamsNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyParamsNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyParamsNode >> right [
	^ right
]

{ #category : #generated }
RpRubyParamsNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyParamsNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyParamsNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyParamsNode >> tokenVariables [
	^ #(left right)
]

{ #category : #generated }
RpRubyParamsNode >> variables [
	^ variables
]

{ #category : #generated }
RpRubyParamsNode >> variables: anOrderedCollection [
	self setParent: self variables to: nil.
	variables := anOrderedCollection.
	self setParent: self variables to: self
]
