Class {
	#name : #RubyUntilModNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'untilToken'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyUntilModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUntilMod: self
]

{ #category : #generated }
RubyUntilModNode >> condition [
	^ condition
]

{ #category : #generated }
RubyUntilModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyUntilModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RubyUntilModNode >> statement [
	^ statement
]

{ #category : #generated }
RubyUntilModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RubyUntilModNode >> tokenVariables [
	^ #(untilToken)
]

{ #category : #generated }
RubyUntilModNode >> untilToken [
	^ untilToken
]

{ #category : #generated }
RubyUntilModNode >> untilToken: aToken [
	untilToken := aToken
]
