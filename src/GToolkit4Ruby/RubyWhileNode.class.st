Class {
	#name : #RubyWhileNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statements',
		'while',
		'end',
		'do',
		'semicolons'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyWhileNode >> acceptVisitor: aVisitor [
	^ aVisitor visitWhile: self
]

{ #category : #generated }
RubyWhileNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyWhileNode >> compositeTokenVariables [
	^ #(semicolons)
]

{ #category : #generated }
RubyWhileNode >> condition [
	^ condition
]

{ #category : #generated }
RubyWhileNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyWhileNode >> do [
	^ do
]

{ #category : #generated }
RubyWhileNode >> do: aToken [
	do := aToken
]

{ #category : #generated }
RubyWhileNode >> end [
	^ end
]

{ #category : #generated }
RubyWhileNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyWhileNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyWhileNode >> nodeVariables [
	^ #(condition)
]

{ #category : #generated }
RubyWhileNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RubyWhileNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RubyWhileNode >> statements [
	^ statements
]

{ #category : #generated }
RubyWhileNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyWhileNode >> tokenVariables [
	^ #(do end while)
]

{ #category : #generated }
RubyWhileNode >> while [
	^ while
]

{ #category : #generated }
RubyWhileNode >> while: aToken [
	while := aToken
]
