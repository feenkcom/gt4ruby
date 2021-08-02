Class {
	#name : #RpRubyWhileNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statements',
		'while',
		'end',
		'do',
		'semicolons'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyWhileNode >> acceptVisitor: aVisitor [
	^ aVisitor visitWhile: self
]

{ #category : #generated }
RpRubyWhileNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyWhileNode >> compositeTokenVariables [
	^ #(semicolons)
]

{ #category : #generated }
RpRubyWhileNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyWhileNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyWhileNode >> do [
	^ do
]

{ #category : #generated }
RpRubyWhileNode >> do: aToken [
	do := aToken
]

{ #category : #generated }
RpRubyWhileNode >> end [
	^ end
]

{ #category : #generated }
RpRubyWhileNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyWhileNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyWhileNode >> nodeVariables [
	^ #(condition)
]

{ #category : #generated }
RpRubyWhileNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RpRubyWhileNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RpRubyWhileNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyWhileNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyWhileNode >> tokenVariables [
	^ #(do end while)
]

{ #category : #generated }
RpRubyWhileNode >> while [
	^ while
]

{ #category : #generated }
RpRubyWhileNode >> while: aToken [
	while := aToken
]
