Class {
	#name : #RubyUnaryNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'operator'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyUnaryNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyUnaryNode >> operator [
	^ operator
]

{ #category : #generated }
RubyUnaryNode >> operator: aToken [
	operator := aToken
]

{ #category : #generated }
RubyUnaryNode >> tokenVariables [
	^ #(operator)
]

{ #category : #generated }
RubyUnaryNode >> value [
	^ value
]

{ #category : #generated }
RubyUnaryNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
