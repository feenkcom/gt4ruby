Class {
	#name : #RpRubyArgumentsNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'arguments',
		'left',
		'right',
		'commas'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyArgumentsNode >> acceptVisitor: aVisitor [
	^ aVisitor visitArguments: self
]

{ #category : #generated }
RpRubyArgumentsNode >> arguments [
	^ arguments
]

{ #category : #generated }
RpRubyArgumentsNode >> arguments: anObject [
	self setParent: self arguments to: nil.
	arguments := anObject.
	self setParent: self arguments to: self
]

{ #category : #generated }
RpRubyArgumentsNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyArgumentsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyArgumentsNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyArgumentsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyArgumentsNode >> left [
	^ left
]

{ #category : #generated }
RpRubyArgumentsNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyArgumentsNode >> otherVariables [
	^ #(arguments)
]

{ #category : #generated }
RpRubyArgumentsNode >> right [
	^ right
]

{ #category : #generated }
RpRubyArgumentsNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyArgumentsNode >> tokenVariables [
	^ #(left right)
]
