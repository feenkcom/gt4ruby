Class {
	#name : #RpRubyArrayReferenceNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'array',
		'indices',
		'left',
		'right',
		'commas',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyArrayReferenceNode >> acceptVisitor: aVisitor [
	^ aVisitor visitArrayReference: self
]

{ #category : #generated }
RpRubyArrayReferenceNode >> array [
	^ array
]

{ #category : #generated }
RpRubyArrayReferenceNode >> array: aNode [
	self array notNil ifTrue: [ self array parent: nil ].
	array := aNode.
	self array notNil ifTrue: [ self array parent: self ]
]

{ #category : #generated }
RpRubyArrayReferenceNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyArrayReferenceNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyArrayReferenceNode >> compositeTokenVariables [
	^ #(commas leftParens rightParens)
]

{ #category : #generated }
RpRubyArrayReferenceNode >> indices [
	^ indices
]

{ #category : #generated }
RpRubyArrayReferenceNode >> indices: anObject [
	self setParent: self indices to: nil.
	indices := anObject.
	self setParent: self indices to: self
]

{ #category : #generated }
RpRubyArrayReferenceNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyArrayReferenceNode >> left [
	^ left
]

{ #category : #generated }
RpRubyArrayReferenceNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyArrayReferenceNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyArrayReferenceNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyArrayReferenceNode >> nodeVariables [
	^ #(array)
]

{ #category : #generated }
RpRubyArrayReferenceNode >> otherVariables [
	^ #(indices)
]

{ #category : #generated }
RpRubyArrayReferenceNode >> right [
	^ right
]

{ #category : #generated }
RpRubyArrayReferenceNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyArrayReferenceNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyArrayReferenceNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyArrayReferenceNode >> tokenVariables [
	^ #(left right)
]
