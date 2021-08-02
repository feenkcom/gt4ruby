Class {
	#name : #RpRubyBlockArgumentNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value',
		'amp'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyBlockArgumentNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBlockArgument: self
]

{ #category : #generated }
RpRubyBlockArgumentNode >> amp [
	^ amp
]

{ #category : #generated }
RpRubyBlockArgumentNode >> amp: aToken [
	amp := aToken
]

{ #category : #generated }
RpRubyBlockArgumentNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyBlockArgumentNode >> tokenVariables [
	^ #(amp)
]

{ #category : #generated }
RpRubyBlockArgumentNode >> value [
	^ value
]

{ #category : #generated }
RpRubyBlockArgumentNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
