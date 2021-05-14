Class {
	#name : #RubyWhileModifierNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'while'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyWhileModifierNode >> condition [
	^ condition
]

{ #category : #generated }
RubyWhileModifierNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyWhileModifierNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RubyWhileModifierNode >> statement [
	^ statement
]

{ #category : #generated }
RubyWhileModifierNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RubyWhileModifierNode >> tokenVariables [
	^ #(while)
]

{ #category : #generated }
RubyWhileModifierNode >> while [
	^ while
]

{ #category : #generated }
RubyWhileModifierNode >> while: aToken [
	while := aToken
]
