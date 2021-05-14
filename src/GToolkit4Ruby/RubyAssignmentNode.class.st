Class {
	#name : #RubyAssignmentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'lhs',
		'value',
		'assignment',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyAssignmentNode >> assignment [
	^ assignment
]

{ #category : #generated }
RubyAssignmentNode >> assignment: aToken [
	assignment := aToken
]

{ #category : #generated }
RubyAssignmentNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyAssignmentNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyAssignmentNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyAssignmentNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyAssignmentNode >> lhs [
	^ lhs
]

{ #category : #generated }
RubyAssignmentNode >> lhs: aNode [
	self lhs notNil ifTrue: [ self lhs parent: nil ].
	lhs := aNode.
	self lhs notNil ifTrue: [ self lhs parent: self ]
]

{ #category : #generated }
RubyAssignmentNode >> nodeVariables [
	^ #(lhs)
]

{ #category : #generated }
RubyAssignmentNode >> otherVariables [
	^ #(value)
]

{ #category : #generated }
RubyAssignmentNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyAssignmentNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyAssignmentNode >> tokenVariables [
	^ #(assignment)
]

{ #category : #generated }
RubyAssignmentNode >> value [
	^ value
]

{ #category : #generated }
RubyAssignmentNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
