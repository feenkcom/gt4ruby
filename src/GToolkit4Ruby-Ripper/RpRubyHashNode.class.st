Class {
	#name : #RpRubyHashNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'associations',
		'left',
		'right',
		'commas',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyHashNode >> acceptVisitor: aVisitor [
	^ aVisitor visitHash: self
]

{ #category : #generated }
RpRubyHashNode >> associations [
	^ associations
]

{ #category : #generated }
RpRubyHashNode >> associations: anOrderedCollection [
	self setParent: self associations to: nil.
	associations := anOrderedCollection.
	self setParent: self associations to: self
]

{ #category : #generated }
RpRubyHashNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyHashNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyHashNode >> compositeNodeVariables [
	^ #(associations)
]

{ #category : #generated }
RpRubyHashNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RpRubyHashNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	associations := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyHashNode >> left [
	^ left
]

{ #category : #generated }
RpRubyHashNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyHashNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyHashNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyHashNode >> right [
	^ right
]

{ #category : #generated }
RpRubyHashNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyHashNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyHashNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyHashNode >> tokenVariables [
	^ #(left right)
]
