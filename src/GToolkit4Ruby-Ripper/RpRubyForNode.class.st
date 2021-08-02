Class {
	#name : #RpRubyForNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'variable',
		'elements',
		'statements',
		'for',
		'in',
		'end'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyForNode >> acceptVisitor: aVisitor [
	^ aVisitor visitFor: self
]

{ #category : #generated }
RpRubyForNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyForNode >> elements [
	^ elements
]

{ #category : #generated }
RpRubyForNode >> elements: aNode [
	self elements notNil ifTrue: [ self elements parent: nil ].
	elements := aNode.
	self elements notNil ifTrue: [ self elements parent: self ]
]

{ #category : #generated }
RpRubyForNode >> end [
	^ end
]

{ #category : #generated }
RpRubyForNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyForNode >> for [
	^ for
]

{ #category : #generated }
RpRubyForNode >> for: aToken [
	for := aToken
]

{ #category : #generated }
RpRubyForNode >> in [
	^ in
]

{ #category : #generated }
RpRubyForNode >> in: aToken [
	in := aToken
]

{ #category : #generated }
RpRubyForNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyForNode >> nodeVariables [
	^ #(elements variable)
]

{ #category : #generated }
RpRubyForNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyForNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyForNode >> tokenVariables [
	^ #(end for in)
]

{ #category : #generated }
RpRubyForNode >> variable [
	^ variable
]

{ #category : #generated }
RpRubyForNode >> variable: aNode [
	self variable notNil ifTrue: [ self variable parent: nil ].
	variable := aNode.
	self variable notNil ifTrue: [ self variable parent: self ]
]
