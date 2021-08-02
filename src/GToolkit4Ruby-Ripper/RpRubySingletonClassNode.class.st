Class {
	#name : #RpRubySingletonClassNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'block',
		'classToken',
		'ltLt',
		'end',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubySingletonClassNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSingletonClass: self
]

{ #category : #generated }
RpRubySingletonClassNode >> block [
	^ block
]

{ #category : #generated }
RpRubySingletonClassNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RpRubySingletonClassNode >> classToken [
	^ classToken
]

{ #category : #generated }
RpRubySingletonClassNode >> classToken: aToken [
	classToken := aToken
]

{ #category : #generated }
RpRubySingletonClassNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubySingletonClassNode >> end [
	^ end
]

{ #category : #generated }
RpRubySingletonClassNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubySingletonClassNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubySingletonClassNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubySingletonClassNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubySingletonClassNode >> ltLt [
	^ ltLt
]

{ #category : #generated }
RpRubySingletonClassNode >> ltLt: aToken [
	ltLt := aToken
]

{ #category : #generated }
RpRubySingletonClassNode >> name [
	^ name
]

{ #category : #generated }
RpRubySingletonClassNode >> name: aNode [
	self name notNil ifTrue: [ self name parent: nil ].
	name := aNode.
	self name notNil ifTrue: [ self name parent: self ]
]

{ #category : #generated }
RpRubySingletonClassNode >> nodeVariables [
	^ #(block name)
]

{ #category : #generated }
RpRubySingletonClassNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubySingletonClassNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubySingletonClassNode >> tokenVariables [
	^ #(classToken end ltLt)
]
