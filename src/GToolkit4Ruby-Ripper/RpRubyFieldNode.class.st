Class {
	#name : #RpRubyFieldNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'receiver',
		'period',
		'name'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyFieldNode >> acceptVisitor: aVisitor [
	^ aVisitor visitField: self
]

{ #category : #generated }
RpRubyFieldNode >> name [
	^ name
]

{ #category : #generated }
RpRubyFieldNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyFieldNode >> nodeVariables [
	^ #(receiver)
]

{ #category : #generated }
RpRubyFieldNode >> period [
	^ period
]

{ #category : #generated }
RpRubyFieldNode >> period: aToken [
	period := aToken
]

{ #category : #generated }
RpRubyFieldNode >> receiver [
	^ receiver
]

{ #category : #generated }
RpRubyFieldNode >> receiver: aNode [
	self receiver notNil ifTrue: [ self receiver parent: nil ].
	receiver := aNode.
	self receiver notNil ifTrue: [ self receiver parent: self ]
]

{ #category : #generated }
RpRubyFieldNode >> tokenVariables [
	^ #(name period)
]
