Class {
	#name : #RubyArrayReferenceNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'array',
		'indices',
		'left',
		'right'
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
RubyArrayReferenceNode >> compositeNodeVariables [
	^ #(indices)
]

{ #category : #generated }
RubyArrayReferenceNode >> indices [
	^ indices
]

{ #category : #generated }
RubyArrayReferenceNode >> indices: anOrderedCollection [
	self setParent: self indices to: nil.
	indices := anOrderedCollection.
	self setParent: self indices to: self
]

{ #category : #generated }
RubyArrayReferenceNode >> initialize [
	super initialize.
	indices := OrderedCollection new: 2
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
RubyArrayReferenceNode >> nodeVariables [
	^ #(array)
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
RubyArrayReferenceNode >> tokenVariables [
	^ #(left right)
]
