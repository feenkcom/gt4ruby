Class {
	#name : #RubyIfExpressionNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'then',
		'else',
		'questionMark',
		'colon',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyIfExpressionNode >> colon [
	^ colon
]

{ #category : #generated }
RubyIfExpressionNode >> colon: aToken [
	colon := aToken
]

{ #category : #generated }
RubyIfExpressionNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyIfExpressionNode >> condition [
	^ condition
]

{ #category : #generated }
RubyIfExpressionNode >> condition: anObject [
	self setParent: self condition to: nil.
	condition := anObject.
	self setParent: self condition to: self
]

{ #category : #generated }
RubyIfExpressionNode >> else [
	^ else
]

{ #category : #generated }
RubyIfExpressionNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RubyIfExpressionNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyIfExpressionNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyIfExpressionNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyIfExpressionNode >> nodeVariables [
	^ #(else then)
]

{ #category : #generated }
RubyIfExpressionNode >> otherVariables [
	^ #(condition)
]

{ #category : #generated }
RubyIfExpressionNode >> questionMark [
	^ questionMark
]

{ #category : #generated }
RubyIfExpressionNode >> questionMark: aToken [
	questionMark := aToken
]

{ #category : #generated }
RubyIfExpressionNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyIfExpressionNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyIfExpressionNode >> then [
	^ then
]

{ #category : #generated }
RubyIfExpressionNode >> then: aNode [
	self then notNil ifTrue: [ self then parent: nil ].
	then := aNode.
	self then notNil ifTrue: [ self then parent: self ]
]

{ #category : #generated }
RubyIfExpressionNode >> tokenVariables [
	^ #(colon questionMark)
]
