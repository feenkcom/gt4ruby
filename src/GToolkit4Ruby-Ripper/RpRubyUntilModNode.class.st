Class {
	#name : #RpRubyUntilModNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'untilToken'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyUntilModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUntilMod: self
]

{ #category : #generated }
RpRubyUntilModNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyUntilModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyUntilModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RpRubyUntilModNode >> statement [
	^ statement
]

{ #category : #generated }
RpRubyUntilModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RpRubyUntilModNode >> tokenVariables [
	^ #(untilToken)
]

{ #category : #generated }
RpRubyUntilModNode >> untilToken [
	^ untilToken
]

{ #category : #generated }
RpRubyUntilModNode >> untilToken: aToken [
	untilToken := aToken
]
