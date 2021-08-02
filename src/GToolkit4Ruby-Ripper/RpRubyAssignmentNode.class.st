Class {
	#name : #RpRubyAssignmentNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'lhs',
		'value',
		'assignment',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyAssignmentNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAssignment: self
]

{ #category : #generated }
RpRubyAssignmentNode >> assignment [
	^ assignment
]

{ #category : #generated }
RpRubyAssignmentNode >> assignment: aToken [
	assignment := aToken
]

{ #category : #generated }
RpRubyAssignmentNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyAssignmentNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyAssignmentNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyAssignmentNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyAssignmentNode >> lhs [
	^ lhs
]

{ #category : #generated }
RpRubyAssignmentNode >> lhs: aNode [
	self lhs notNil ifTrue: [ self lhs parent: nil ].
	lhs := aNode.
	self lhs notNil ifTrue: [ self lhs parent: self ]
]

{ #category : #generated }
RpRubyAssignmentNode >> nodeVariables [
	^ #(lhs)
]

{ #category : #generated }
RpRubyAssignmentNode >> otherVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyAssignmentNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyAssignmentNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyAssignmentNode >> tokenVariables [
	^ #(assignment)
]

{ #category : #generated }
RpRubyAssignmentNode >> value [
	^ value
]

{ #category : #generated }
RpRubyAssignmentNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
