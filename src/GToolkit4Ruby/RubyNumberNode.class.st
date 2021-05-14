Class {
	#name : #RubyNumberNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyNumberNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RubyNumberNode >> value [
	^ value
]

{ #category : #generated }
RubyNumberNode >> value: aToken [
	value := aToken
]
