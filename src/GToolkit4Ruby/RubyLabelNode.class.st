Class {
	#name : #RubyLabelNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyLabelNode >> acceptVisitor: aVisitor [
	^ aVisitor visitLabel: self
]

{ #category : #generated }
RubyLabelNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RubyLabelNode >> value [
	^ value
]

{ #category : #generated }
RubyLabelNode >> value: aToken [
	value := aToken
]
