Class {
	#name : #RpRubyLhsVariablesNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'variables',
		'left',
		'right',
		'commas'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyLhsVariablesNode >> acceptVisitor: aVisitor [
	^ aVisitor visitLhsVariables: self
]

{ #category : #generated }
RpRubyLhsVariablesNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyLhsVariablesNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyLhsVariablesNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyLhsVariablesNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyLhsVariablesNode >> left [
	^ left
]

{ #category : #generated }
RpRubyLhsVariablesNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyLhsVariablesNode >> otherVariables [
	^ #(variables)
]

{ #category : #generated }
RpRubyLhsVariablesNode >> right [
	^ right
]

{ #category : #generated }
RpRubyLhsVariablesNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyLhsVariablesNode >> tokenVariables [
	^ #(left right)
]

{ #category : #generated }
RpRubyLhsVariablesNode >> variables [
	^ variables
]

{ #category : #generated }
RpRubyLhsVariablesNode >> variables: anObject [
	self setParent: self variables to: nil.
	variables := anObject.
	self setParent: self variables to: self
]
