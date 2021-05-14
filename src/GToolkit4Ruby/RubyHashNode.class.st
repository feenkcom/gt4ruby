Class {
	#name : #RubyHashNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'associations',
		'left',
		'right',
		'commas',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyHashNode >> associations [
	^ associations
]

{ #category : #generated }
RubyHashNode >> associations: anOrderedCollection [
	self setParent: self associations to: nil.
	associations := anOrderedCollection.
	self setParent: self associations to: self
]

{ #category : #generated }
RubyHashNode >> commas [
	^ commas
]

{ #category : #generated }
RubyHashNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyHashNode >> compositeNodeVariables [
	^ #(associations)
]

{ #category : #generated }
RubyHashNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RubyHashNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	associations := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyHashNode >> left [
	^ left
]

{ #category : #generated }
RubyHashNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyHashNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyHashNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyHashNode >> right [
	^ right
]

{ #category : #generated }
RubyHashNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyHashNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyHashNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyHashNode >> tokenVariables [
	^ #(left right)
]
