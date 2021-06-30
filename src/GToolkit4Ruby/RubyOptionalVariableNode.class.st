Class {
	#name : #RubyOptionalVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyOptionalVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitOptionalVariable: self
]

{ #category : #generated }
RubyOptionalVariableNode >> equals [
	^ equals
]

{ #category : #generated }
RubyOptionalVariableNode >> equals: aToken [
	equals := aToken
]

{ #category : #generated }
RubyOptionalVariableNode >> name [
	^ name
]

{ #category : #generated }
RubyOptionalVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyOptionalVariableNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyOptionalVariableNode >> tokenVariables [
	^ #(equals name)
]

{ #category : #generated }
RubyOptionalVariableNode >> value [
	^ value
]

{ #category : #generated }
RubyOptionalVariableNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
