Class {
	#name : #RubySingletonClassNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'block',
		'classToken',
		'ltLt',
		'end',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubySingletonClassNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSingletonClass: self
]

{ #category : #generated }
RubySingletonClassNode >> block [
	^ block
]

{ #category : #generated }
RubySingletonClassNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RubySingletonClassNode >> classToken [
	^ classToken
]

{ #category : #generated }
RubySingletonClassNode >> classToken: aToken [
	classToken := aToken
]

{ #category : #generated }
RubySingletonClassNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubySingletonClassNode >> end [
	^ end
]

{ #category : #generated }
RubySingletonClassNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubySingletonClassNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubySingletonClassNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubySingletonClassNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubySingletonClassNode >> ltLt [
	^ ltLt
]

{ #category : #generated }
RubySingletonClassNode >> ltLt: aToken [
	ltLt := aToken
]

{ #category : #generated }
RubySingletonClassNode >> name [
	^ name
]

{ #category : #generated }
RubySingletonClassNode >> name: aNode [
	self name notNil ifTrue: [ self name parent: nil ].
	name := aNode.
	self name notNil ifTrue: [ self name parent: self ]
]

{ #category : #generated }
RubySingletonClassNode >> nodeVariables [
	^ #(block name)
]

{ #category : #generated }
RubySingletonClassNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubySingletonClassNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubySingletonClassNode >> tokenVariables [
	^ #(classToken end ltLt)
]
