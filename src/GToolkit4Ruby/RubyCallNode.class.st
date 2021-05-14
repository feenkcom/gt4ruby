Class {
	#name : #RubyCallNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'arguments',
		'name',
		'receiver',
		'period',
		'block'
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
RubyCallNode >> name [
	^ name
]

{ #category : #generated }
RubyCallNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyCallNode >> nodeVariables [
	^ #(arguments block receiver)
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
RubyCallNode >> receiver: aNode [
	self receiver notNil ifTrue: [ self receiver parent: nil ].
	receiver := aNode.
	self receiver notNil ifTrue: [ self receiver parent: self ]
]

{ #category : #generated }
RubyCallNode >> tokenVariables [
	^ #(name period)
]
