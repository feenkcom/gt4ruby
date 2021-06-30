Class {
	#name : #RubyNextNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'next',
		'value'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyNextNode >> acceptVisitor: aVisitor [
	^ aVisitor visitNext: self
]

{ #category : #generated }
RubyNextNode >> next [
	^ next
]

{ #category : #generated }
RubyNextNode >> next: aToken [
	next := aToken
]

{ #category : #generated }
RubyNextNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyNextNode >> tokenVariables [
	^ #(next)
]

{ #category : #generated }
RubyNextNode >> value [
	^ value
]

{ #category : #generated }
RubyNextNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
