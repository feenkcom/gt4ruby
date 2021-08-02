Class {
	#name : #RpRubyWhileModifierNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'while'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyWhileModifierNode >> acceptVisitor: aVisitor [
	^ aVisitor visitWhileModifier: self
]

{ #category : #generated }
RpRubyWhileModifierNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyWhileModifierNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyWhileModifierNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RpRubyWhileModifierNode >> statement [
	^ statement
]

{ #category : #generated }
RpRubyWhileModifierNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RpRubyWhileModifierNode >> tokenVariables [
	^ #(while)
]

{ #category : #generated }
RpRubyWhileModifierNode >> while [
	^ while
]

{ #category : #generated }
RpRubyWhileModifierNode >> while: aToken [
	while := aToken
]
