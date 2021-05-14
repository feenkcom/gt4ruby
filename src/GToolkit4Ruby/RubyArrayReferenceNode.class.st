Class {
	#name : #RubyArrayReferenceNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'array',
		'indices',
		'left',
		'right',
		'commas',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyArrayReferenceNode >> array [
	^ array
]

{ #category : #generated }
RubyArrayReferenceNode >> array: aNode [
	self array notNil ifTrue: [ self array parent: nil ].
	array := aNode.
	self array notNil ifTrue: [ self array parent: self ]
]

{ #category : #generated }
RubyArrayReferenceNode >> commas [
	^ commas
]

{ #category : #generated }
RubyArrayReferenceNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyArrayReferenceNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RubyArrayReferenceNode >> indices [
	^ indices
]

{ #category : #generated }
RubyArrayReferenceNode >> indices: anObject [
	self setParent: self indices to: nil.
	indices := anObject.
	self setParent: self indices to: self
]

{ #category : #generated }
RubyArrayReferenceNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyArrayReferenceNode >> left [
	^ left
]

{ #category : #generated }
RubyArrayReferenceNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyArrayReferenceNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyArrayReferenceNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyArrayReferenceNode >> nodeVariables [
	^ #(array)
]

{ #category : #generated }
RubyArrayReferenceNode >> otherVariables [
	^ #(indices)
]

{ #category : #generated }
RubyArrayReferenceNode >> right [
	^ right
]

{ #category : #generated }
RubyArrayReferenceNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyArrayReferenceNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyArrayReferenceNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyArrayReferenceNode >> tokenVariables [
	^ #(left right)
]
