Class {
	#name : #RubySplatVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variable',
		'star',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubySplatVariableNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubySplatVariableNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubySplatVariableNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubySplatVariableNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubySplatVariableNode >> otherVariables [
	^ #(variable)
]

{ #category : #generated }
RubySplatVariableNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubySplatVariableNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

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
	^ #(star)
]

{ #category : #generated }
RubySplatVariableNode >> variable [
	^ variable
]

{ #category : #generated }
RubySplatVariableNode >> variable: anObject [
	self setParent: self variable to: nil.
	variable := anObject.
	self setParent: self variable to: self
]
