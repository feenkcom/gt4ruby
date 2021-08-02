Class {
	#name : #RpRubyUnlessModNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'unlessToken'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyUnlessModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUnlessMod: self
]

{ #category : #generated }
RpRubyUnlessModNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyUnlessModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyUnlessModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RpRubyUnlessModNode >> statement [
	^ statement
]

{ #category : #generated }
RpRubyUnlessModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RpRubyUnlessModNode >> tokenVariables [
	^ #(unlessToken)
]

{ #category : #generated }
RpRubyUnlessModNode >> unlessToken [
	^ unlessToken
]

{ #category : #generated }
RpRubyUnlessModNode >> unlessToken: aToken [
	unlessToken := aToken
]
