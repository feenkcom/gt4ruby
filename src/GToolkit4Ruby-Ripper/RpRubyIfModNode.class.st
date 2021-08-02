Class {
	#name : #RpRubyIfModNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'ifToken',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyIfModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitIfMod: self
]

{ #category : #generated }
RpRubyIfModNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyIfModNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyIfModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyIfModNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
RpRubyIfModNode >> ifToken: aToken [
	ifToken := aToken
]

{ #category : #generated }
RpRubyIfModNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyIfModNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyIfModNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyIfModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RpRubyIfModNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyIfModNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyIfModNode >> statement [
	^ statement
]

{ #category : #generated }
RpRubyIfModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RpRubyIfModNode >> tokenVariables [
	^ #(ifToken)
]
