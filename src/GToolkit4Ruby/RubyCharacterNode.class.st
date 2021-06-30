Class {
	#name : #RubyCharacterNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyCharacterNode >> acceptVisitor: aVisitor [
	^ aVisitor visitCharacter: self
]

{ #category : #generated }
RubyCharacterNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RubyCharacterNode >> value [
	^ value
]

{ #category : #generated }
RubyCharacterNode >> value: aToken [
	value := aToken
]
