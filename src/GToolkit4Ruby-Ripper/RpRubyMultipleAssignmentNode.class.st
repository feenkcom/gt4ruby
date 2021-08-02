Class {
	#name : #RpRubyMultipleAssignmentNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'variables',
		'value',
		'commas',
		'assignment'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyMultipleAssignmentNode >> acceptVisitor: aVisitor [
	^ aVisitor visitMultipleAssignment: self
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> assignment [
	^ assignment
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> assignment: aToken [
	assignment := aToken
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> compositeNodeVariables [
	^ #(variables)
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	variables := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> tokenVariables [
	^ #(assignment)
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> value [
	^ value
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> variables [
	^ variables
]

{ #category : #generated }
RpRubyMultipleAssignmentNode >> variables: anOrderedCollection [
	self setParent: self variables to: nil.
	variables := anOrderedCollection.
	self setParent: self variables to: self
]
