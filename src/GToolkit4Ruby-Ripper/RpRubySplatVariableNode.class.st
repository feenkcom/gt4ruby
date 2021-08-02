Class {
	#name : #RpRubySplatVariableNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'variable',
		'star',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubySplatVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSplatVariable: self
]

{ #category : #generated }
RpRubySplatVariableNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubySplatVariableNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubySplatVariableNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubySplatVariableNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubySplatVariableNode >> otherVariables [
	^ #(variable)
]

{ #category : #generated }
RpRubySplatVariableNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubySplatVariableNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubySplatVariableNode >> star [
	^ star
]

{ #category : #generated }
RpRubySplatVariableNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RpRubySplatVariableNode >> tokenVariables [
	^ #(star)
]

{ #category : #generated }
RpRubySplatVariableNode >> variable [
	^ variable
]

{ #category : #generated }
RpRubySplatVariableNode >> variable: anObject [
	self setParent: self variable to: nil.
	variable := anObject.
	self setParent: self variable to: self
]
