Class {
	#name : #RubySplatVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variable',
		'star'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubySplatVariableNode >> star [
	^ star
]

{ #category : #generated }
RubySplatVariableNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RubySplatVariableNode >> tokenVariables [
	^ #(star variable)
]

{ #category : #generated }
RubySplatVariableNode >> variable [
	^ variable
]

{ #category : #generated }
RubySplatVariableNode >> variable: aToken [
	variable := aToken
]
