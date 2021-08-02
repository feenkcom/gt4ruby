Class {
	#name : #RpRubyBinaryNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'left',
		'right',
		'operator',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyBinaryNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBinary: self
]

{ #category : #generated }
RpRubyBinaryNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyBinaryNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyBinaryNode >> left [
	^ left
]

{ #category : #generated }
RpRubyBinaryNode >> left: anObject [
	self setParent: self left to: nil.
	left := anObject.
	self setParent: self left to: self
]

{ #category : #generated }
RpRubyBinaryNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyBinaryNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyBinaryNode >> operator [
	^ operator
]

{ #category : #generated }
RpRubyBinaryNode >> operator: aToken [
	operator := aToken
]

{ #category : #generated }
RpRubyBinaryNode >> otherVariables [
	^ #(left right)
]

{ #category : #generated }
RpRubyBinaryNode >> right [
	^ right
]

{ #category : #generated }
RpRubyBinaryNode >> right: anObject [
	self setParent: self right to: nil.
	right := anObject.
	self setParent: self right to: self
]

{ #category : #generated }
RpRubyBinaryNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyBinaryNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyBinaryNode >> tokenVariables [
	^ #(operator)
]
