Class {
	#name : #RubyNumberNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyNumberNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyNumberNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyNumberNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyNumberNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyNumberNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyNumberNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

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
