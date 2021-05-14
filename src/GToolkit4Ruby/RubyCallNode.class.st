Class {
	#name : #RubyCallNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'arguments',
		'name',
		'receiver',
		'period',
		'block',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyCallNode >> arguments [
	^ arguments
]

{ #category : #generated }
RubyCallNode >> arguments: aNode [
	self arguments notNil ifTrue: [ self arguments parent: nil ].
	arguments := aNode.
	self arguments notNil ifTrue: [ self arguments parent: self ]
]

{ #category : #generated }
RubyCallNode >> block [
	^ block
]

{ #category : #generated }
RubyCallNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RubyCallNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyCallNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyCallNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyCallNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyCallNode >> name [
	^ name
]

{ #category : #generated }
RubyCallNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyCallNode >> nodeVariables [
	^ #(arguments block)
]

{ #category : #generated }
RubyCallNode >> otherVariables [
	^ #(receiver)
]

{ #category : #generated }
RubyCallNode >> period [
	^ period
]

{ #category : #generated }
RubyCallNode >> period: aToken [
	period := aToken
]

{ #category : #generated }
RubyCallNode >> receiver [
	^ receiver
]

{ #category : #generated }
RubyCallNode >> receiver: anObject [
	self setParent: self receiver to: nil.
	receiver := anObject.
	self setParent: self receiver to: self
]

{ #category : #generated }
RubyCallNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyCallNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyCallNode >> tokenVariables [
	^ #(name period)
]
