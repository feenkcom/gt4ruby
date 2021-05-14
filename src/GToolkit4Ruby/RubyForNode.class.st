Class {
	#name : #RubyForNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variable',
		'elements',
		'statements',
		'for',
		'in',
		'end'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyForNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyForNode >> elements [
	^ elements
]

{ #category : #generated }
RubyForNode >> elements: aNode [
	self elements notNil ifTrue: [ self elements parent: nil ].
	elements := aNode.
	self elements notNil ifTrue: [ self elements parent: self ]
]

{ #category : #generated }
RubyForNode >> end [
	^ end
]

{ #category : #generated }
RubyForNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyForNode >> for [
	^ for
]

{ #category : #generated }
RubyForNode >> for: aToken [
	for := aToken
]

{ #category : #generated }
RubyForNode >> in [
	^ in
]

{ #category : #generated }
RubyForNode >> in: aToken [
	in := aToken
]

{ #category : #generated }
RubyForNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyForNode >> nodeVariables [
	^ #(elements variable)
]

{ #category : #generated }
RubyForNode >> statements [
	^ statements
]

{ #category : #generated }
RubyForNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyForNode >> tokenVariables [
	^ #(end for in)
]

{ #category : #generated }
RubyForNode >> variable [
	^ variable
]

{ #category : #generated }
RubyForNode >> variable: aNode [
	self variable notNil ifTrue: [ self variable parent: nil ].
	variable := aNode.
	self variable notNil ifTrue: [ self variable parent: self ]
]
