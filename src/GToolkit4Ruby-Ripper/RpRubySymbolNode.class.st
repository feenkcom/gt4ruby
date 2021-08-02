Class {
	#name : #RpRubySymbolNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'colon',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubySymbolNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSymbol: self
]

{ #category : #generated }
RpRubySymbolNode >> colon [
	^ colon
]

{ #category : #generated }
RpRubySymbolNode >> colon: aToken [
	colon := aToken
]

{ #category : #generated }
RpRubySymbolNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubySymbolNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubySymbolNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubySymbolNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubySymbolNode >> name [
	^ name
]

{ #category : #generated }
RpRubySymbolNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubySymbolNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubySymbolNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubySymbolNode >> tokenVariables [
	^ #(colon name)
]
