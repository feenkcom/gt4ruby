Class {
	#name : #RubyRescueModNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'expression',
		'value',
		'rescue',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyRescueModNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyRescueModNode >> expression [
	^ expression
]

{ #category : #generated }
RubyRescueModNode >> expression: aNode [
	self expression notNil ifTrue: [ self expression parent: nil ].
	expression := aNode.
	self expression notNil ifTrue: [ self expression parent: self ]
]

{ #category : #generated }
RubyRescueModNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyRescueModNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyRescueModNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyRescueModNode >> nodeVariables [
	^ #(expression value)
]

{ #category : #generated }
RubyRescueModNode >> rescue [
	^ rescue
]

{ #category : #generated }
RubyRescueModNode >> rescue: aToken [
	rescue := aToken
]

{ #category : #generated }
RubyRescueModNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyRescueModNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyRescueModNode >> tokenVariables [
	^ #(rescue)
]

{ #category : #generated }
RubyRescueModNode >> value [
	^ value
]

{ #category : #generated }
RubyRescueModNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
