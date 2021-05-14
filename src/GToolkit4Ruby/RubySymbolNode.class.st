Class {
	#name : #RubySymbolNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'colon',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubySymbolNode >> colon [
	^ colon
]

{ #category : #generated }
RubySymbolNode >> colon: aToken [
	colon := aToken
]

{ #category : #generated }
RubySymbolNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubySymbolNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubySymbolNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubySymbolNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubySymbolNode >> name [
	^ name
]

{ #category : #generated }
RubySymbolNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubySymbolNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubySymbolNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubySymbolNode >> tokenVariables [
	^ #(colon name)
]
