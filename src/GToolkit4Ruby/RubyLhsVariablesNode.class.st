Class {
	#name : #RubyLhsVariablesNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variables',
		'left',
		'right',
		'commas'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyLhsVariablesNode >> commas [
	^ commas
]

{ #category : #generated }
RubyLhsVariablesNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyLhsVariablesNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyLhsVariablesNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2
]

{ #category : #generated }
RubyLhsVariablesNode >> left [
	^ left
]

{ #category : #generated }
RubyLhsVariablesNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyLhsVariablesNode >> otherVariables [
	^ #(variables)
]

{ #category : #generated }
RubyLhsVariablesNode >> right [
	^ right
]

{ #category : #generated }
RubyLhsVariablesNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyLhsVariablesNode >> tokenVariables [
	^ #(left right)
]

{ #category : #generated }
RubyLhsVariablesNode >> variables [
	^ variables
]

{ #category : #generated }
RubyLhsVariablesNode >> variables: anObject [
	self setParent: self variables to: nil.
	variables := anObject.
	self setParent: self variables to: self
]
