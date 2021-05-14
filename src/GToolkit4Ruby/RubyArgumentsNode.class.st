Class {
	#name : #RubyArgumentsNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'arguments',
		'left',
		'right',
		'commas'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyArgumentsNode >> arguments [
	^ arguments
]

{ #category : #generated }
RubyArgumentsNode >> arguments: anOrderedCollection [
	self setParent: self arguments to: nil.
	arguments := anOrderedCollection.
	self setParent: self arguments to: self
]

{ #category : #generated }
RubyArgumentsNode >> commas [
	^ commas
]

{ #category : #generated }
RubyArgumentsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyArgumentsNode >> compositeNodeVariables [
	^ #(arguments)
]

{ #category : #generated }
RubyArgumentsNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyArgumentsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	arguments := OrderedCollection new: 2
]

{ #category : #generated }
RubyArgumentsNode >> left [
	^ left
]

{ #category : #generated }
RubyArgumentsNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyArgumentsNode >> right [
	^ right
]

{ #category : #generated }
RubyArgumentsNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyArgumentsNode >> tokenVariables [
	^ #(left right)
]
