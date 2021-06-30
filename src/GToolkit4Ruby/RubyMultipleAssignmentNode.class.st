Class {
	#name : #RubyMultipleAssignmentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variables',
		'value',
		'commas',
		'assignment'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyMultipleAssignmentNode >> acceptVisitor: aVisitor [
	^ aVisitor visitMultipleAssignment: self
]

{ #category : #generated }
RubyMultipleAssignmentNode >> assignment [
	^ assignment
]

{ #category : #generated }
RubyMultipleAssignmentNode >> assignment: aToken [
	assignment := aToken
]

{ #category : #generated }
RubyMultipleAssignmentNode >> commas [
	^ commas
]

{ #category : #generated }
RubyMultipleAssignmentNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyMultipleAssignmentNode >> compositeNodeVariables [
	^ #(variables)
]

{ #category : #generated }
RubyMultipleAssignmentNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyMultipleAssignmentNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	variables := OrderedCollection new: 2
]

{ #category : #generated }
RubyMultipleAssignmentNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyMultipleAssignmentNode >> tokenVariables [
	^ #(assignment)
]

{ #category : #generated }
RubyMultipleAssignmentNode >> value [
	^ value
]

{ #category : #generated }
RubyMultipleAssignmentNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]

{ #category : #generated }
RubyMultipleAssignmentNode >> variables [
	^ variables
]

{ #category : #generated }
RubyMultipleAssignmentNode >> variables: anOrderedCollection [
	self setParent: self variables to: nil.
	variables := anOrderedCollection.
	self setParent: self variables to: self
]
