Class {
	#name : #RubyUnlessModNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'unlessToken'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyUnlessModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUnlessMod: self
]

{ #category : #generated }
RubyUnlessModNode >> condition [
	^ condition
]

{ #category : #generated }
RubyUnlessModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyUnlessModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RubyUnlessModNode >> statement [
	^ statement
]

{ #category : #generated }
RubyUnlessModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RubyUnlessModNode >> tokenVariables [
	^ #(unlessToken)
]

{ #category : #generated }
RubyUnlessModNode >> unlessToken [
	^ unlessToken
]

{ #category : #generated }
RubyUnlessModNode >> unlessToken: aToken [
	unlessToken := aToken
]
