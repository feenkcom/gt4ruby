Class {
	#name : #RpRubyCharacterNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyCharacterNode >> acceptVisitor: aVisitor [
	^ aVisitor visitCharacter: self
]

{ #category : #generated }
RpRubyCharacterNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyCharacterNode >> value [
	^ value
]

{ #category : #generated }
RpRubyCharacterNode >> value: aToken [
	value := aToken
]
