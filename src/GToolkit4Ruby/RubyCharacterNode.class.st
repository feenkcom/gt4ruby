Class {
	#name : #RubyCharacterNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value'
	],
	#category : #GToolkit4Ruby
}

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
