Class {
	#name : #RubyUnaryNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'operator',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyUnaryNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyUnaryNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyUnaryNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyUnaryNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyUnaryNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyUnaryNode >> operator [
	^ operator
]

{ #category : #generated }
RubyUnaryNode >> operator: aToken [
	operator := aToken
]

{ #category : #generated }
RubyUnaryNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyUnaryNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyUnaryNode >> tokenVariables [
	^ #(operator)
]

{ #category : #generated }
RubyUnaryNode >> value [
	^ value
]

{ #category : #generated }
RubyUnaryNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
