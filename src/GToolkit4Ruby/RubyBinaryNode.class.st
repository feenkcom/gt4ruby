Class {
	#name : #RubyBinaryNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'left',
		'right',
		'operator',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyBinaryNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyBinaryNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyBinaryNode >> left [
	^ left
]

{ #category : #generated }
RubyBinaryNode >> left: aNode [
	self left notNil ifTrue: [ self left parent: nil ].
	left := aNode.
	self left notNil ifTrue: [ self left parent: self ]
]

{ #category : #generated }
RubyBinaryNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyBinaryNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyBinaryNode >> nodeVariables [
	^ #(left right)
]

{ #category : #generated }
RubyBinaryNode >> operator [
	^ operator
]

{ #category : #generated }
RubyBinaryNode >> operator: aToken [
	operator := aToken
]

{ #category : #generated }
RubyBinaryNode >> right [
	^ right
]

{ #category : #generated }
RubyBinaryNode >> right: aNode [
	self right notNil ifTrue: [ self right parent: nil ].
	right := aNode.
	self right notNil ifTrue: [ self right parent: self ]
]

{ #category : #generated }
RubyBinaryNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyBinaryNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyBinaryNode >> tokenVariables [
	^ #(operator)
]
