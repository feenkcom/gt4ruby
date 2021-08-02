Class {
	#name : #RpRubyRescueModNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'expression',
		'value',
		'rescue',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRescueModNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRescueMod: self
]

{ #category : #generated }
RpRubyRescueModNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyRescueModNode >> expression [
	^ expression
]

{ #category : #generated }
RpRubyRescueModNode >> expression: aNode [
	self expression notNil ifTrue: [ self expression parent: nil ].
	expression := aNode.
	self expression notNil ifTrue: [ self expression parent: self ]
]

{ #category : #generated }
RpRubyRescueModNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyRescueModNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyRescueModNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyRescueModNode >> nodeVariables [
	^ #(expression value)
]

{ #category : #generated }
RpRubyRescueModNode >> rescue [
	^ rescue
]

{ #category : #generated }
RpRubyRescueModNode >> rescue: aToken [
	rescue := aToken
]

{ #category : #generated }
RpRubyRescueModNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyRescueModNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyRescueModNode >> tokenVariables [
	^ #(rescue)
]

{ #category : #generated }
RpRubyRescueModNode >> value [
	^ value
]

{ #category : #generated }
RpRubyRescueModNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
