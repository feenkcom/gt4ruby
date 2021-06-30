Class {
	#name : #RubyFieldNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'receiver',
		'period',
		'name'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyFieldNode >> acceptVisitor: aVisitor [
	^ aVisitor visitField: self
]

{ #category : #generated }
RubyFieldNode >> name [
	^ name
]

{ #category : #generated }
RubyFieldNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyFieldNode >> nodeVariables [
	^ #(receiver)
]

{ #category : #generated }
RubyFieldNode >> period [
	^ period
]

{ #category : #generated }
RubyFieldNode >> period: aToken [
	period := aToken
]

{ #category : #generated }
RubyFieldNode >> receiver [
	^ receiver
]

{ #category : #generated }
RubyFieldNode >> receiver: aNode [
	self receiver notNil ifTrue: [ self receiver parent: nil ].
	receiver := aNode.
	self receiver notNil ifTrue: [ self receiver parent: self ]
]

{ #category : #generated }
RubyFieldNode >> tokenVariables [
	^ #(name period)
]
