Class {
	#name : #RpRubyIfExpressionNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'then',
		'else',
		'questionMark',
		'colon',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyIfExpressionNode >> acceptVisitor: aVisitor [
	^ aVisitor visitIfExpression: self
]

{ #category : #generated }
RpRubyIfExpressionNode >> colon [
	^ colon
]

{ #category : #generated }
RpRubyIfExpressionNode >> colon: aToken [
	colon := aToken
]

{ #category : #generated }
RpRubyIfExpressionNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyIfExpressionNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyIfExpressionNode >> condition: anObject [
	self setParent: self condition to: nil.
	condition := anObject.
	self setParent: self condition to: self
]

{ #category : #generated }
RpRubyIfExpressionNode >> else [
	^ else
]

{ #category : #generated }
RpRubyIfExpressionNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RpRubyIfExpressionNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyIfExpressionNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyIfExpressionNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyIfExpressionNode >> nodeVariables [
	^ #(else then)
]

{ #category : #generated }
RpRubyIfExpressionNode >> otherVariables [
	^ #(condition)
]

{ #category : #generated }
RpRubyIfExpressionNode >> questionMark [
	^ questionMark
]

{ #category : #generated }
RpRubyIfExpressionNode >> questionMark: aToken [
	questionMark := aToken
]

{ #category : #generated }
RpRubyIfExpressionNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyIfExpressionNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyIfExpressionNode >> then [
	^ then
]

{ #category : #generated }
RpRubyIfExpressionNode >> then: aNode [
	self then notNil ifTrue: [ self then parent: nil ].
	then := aNode.
	self then notNil ifTrue: [ self then parent: self ]
]

{ #category : #generated }
RpRubyIfExpressionNode >> tokenVariables [
	^ #(colon questionMark)
]
