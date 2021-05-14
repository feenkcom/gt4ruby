Class {
	#name : #RubyBlockArgumentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'amp'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyBlockArgumentNode >> amp [
	^ amp
]

{ #category : #generated }
RubyBlockArgumentNode >> amp: aToken [
	amp := aToken
]

{ #category : #generated }
RubyBlockArgumentNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyBlockArgumentNode >> tokenVariables [
	^ #(amp)
]

{ #category : #generated }
RubyBlockArgumentNode >> value [
	^ value
]

{ #category : #generated }
RubyBlockArgumentNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
