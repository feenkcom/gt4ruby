Class {
	#name : #RubyUntilNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statements',
		'until',
		'do',
		'end'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyUntilNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUntil: self
]

{ #category : #generated }
RubyUntilNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyUntilNode >> condition [
	^ condition
]

{ #category : #generated }
RubyUntilNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyUntilNode >> do [
	^ do
]

{ #category : #generated }
RubyUntilNode >> do: aToken [
	do := aToken
]

{ #category : #generated }
RubyUntilNode >> end [
	^ end
]

{ #category : #generated }
RubyUntilNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyUntilNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyUntilNode >> nodeVariables [
	^ #(condition)
]

{ #category : #generated }
RubyUntilNode >> statements [
	^ statements
]

{ #category : #generated }
RubyUntilNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyUntilNode >> tokenVariables [
	^ #(do end until)
]

{ #category : #generated }
RubyUntilNode >> until [
	^ until
]

{ #category : #generated }
RubyUntilNode >> until: aToken [
	until := aToken
]
