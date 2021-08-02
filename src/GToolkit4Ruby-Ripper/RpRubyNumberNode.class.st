Class {
	#name : #RpRubyNumberNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyNumberNode >> acceptVisitor: aVisitor [
	^ aVisitor visitNumber: self
]

{ #category : #generated }
RpRubyNumberNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyNumberNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyNumberNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyNumberNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyNumberNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyNumberNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyNumberNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyNumberNode >> value [
	^ value
]

{ #category : #generated }
RpRubyNumberNode >> value: aToken [
	value := aToken
]
