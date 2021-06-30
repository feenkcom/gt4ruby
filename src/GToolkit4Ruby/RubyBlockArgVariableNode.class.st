Class {
	#name : #RubyBlockArgVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'amp'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyBlockArgVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBlockArgVariable: self
]

{ #category : #generated }
RubyBlockArgVariableNode >> amp [
	^ amp
]

{ #category : #generated }
RubyBlockArgVariableNode >> amp: aToken [
	amp := aToken
]

{ #category : #generated }
RubyBlockArgVariableNode >> name [
	^ name
]

{ #category : #generated }
RubyBlockArgVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyBlockArgVariableNode >> tokenVariables [
	^ #(amp name)
]
