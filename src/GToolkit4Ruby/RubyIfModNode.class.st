Class {
	#name : #RubyIfModNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'ifToken',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyIfModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitIfMod: self
]

{ #category : #generated }
RubyIfModNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyIfModNode >> condition [
	^ condition
]

{ #category : #generated }
RubyIfModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyIfModNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
RubyIfModNode >> ifToken: aToken [
	ifToken := aToken
]

{ #category : #generated }
RubyIfModNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyIfModNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyIfModNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyIfModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RubyIfModNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyIfModNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyIfModNode >> statement [
	^ statement
]

{ #category : #generated }
RubyIfModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RubyIfModNode >> tokenVariables [
	^ #(ifToken)
]
