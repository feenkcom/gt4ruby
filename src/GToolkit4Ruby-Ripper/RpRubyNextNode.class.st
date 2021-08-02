Class {
	#name : #RpRubyNextNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'next',
		'value'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyNextNode >> acceptVisitor: aVisitor [
	^ aVisitor visitNext: self
]

{ #category : #generated }
RpRubyNextNode >> next [
	^ next
]

{ #category : #generated }
RpRubyNextNode >> next: aToken [
	next := aToken
]

{ #category : #generated }
RpRubyNextNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyNextNode >> tokenVariables [
	^ #(next)
]

{ #category : #generated }
RpRubyNextNode >> value [
	^ value
]

{ #category : #generated }
RpRubyNextNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
