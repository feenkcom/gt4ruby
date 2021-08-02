Class {
	#name : #RpRubyCallNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'arguments',
		'name',
		'receiver',
		'period',
		'block',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyCallNode >> acceptVisitor: aVisitor [
	^ aVisitor visitCall: self
]

{ #category : #generated }
RpRubyCallNode >> arguments [
	^ arguments
]

{ #category : #generated }
RpRubyCallNode >> arguments: aNode [
	self arguments notNil ifTrue: [ self arguments parent: nil ].
	arguments := aNode.
	self arguments notNil ifTrue: [ self arguments parent: self ]
]

{ #category : #generated }
RpRubyCallNode >> block [
	^ block
]

{ #category : #generated }
RpRubyCallNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RpRubyCallNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyCallNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyCallNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyCallNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyCallNode >> name [
	^ name
]

{ #category : #generated }
RpRubyCallNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyCallNode >> nodeVariables [
	^ #(arguments block)
]

{ #category : #generated }
RpRubyCallNode >> otherVariables [
	^ #(receiver)
]

{ #category : #generated }
RpRubyCallNode >> period [
	^ period
]

{ #category : #generated }
RpRubyCallNode >> period: aToken [
	period := aToken
]

{ #category : #generated }
RpRubyCallNode >> receiver [
	^ receiver
]

{ #category : #generated }
RpRubyCallNode >> receiver: anObject [
	self setParent: self receiver to: nil.
	receiver := anObject.
	self setParent: self receiver to: self
]

{ #category : #generated }
RpRubyCallNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyCallNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyCallNode >> tokenVariables [
	^ #(name period)
]
