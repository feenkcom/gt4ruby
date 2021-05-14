Class {
	#name : #RubyAssignmentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'lhs',
		'value',
		'assignment'
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
	^ #(lhs value)
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
RubyAssignmentNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
