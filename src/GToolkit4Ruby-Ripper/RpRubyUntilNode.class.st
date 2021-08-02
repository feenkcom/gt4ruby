Class {
	#name : #RpRubyUntilNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statements',
		'until',
		'do',
		'end'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyUntilNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUntil: self
]

{ #category : #generated }
RpRubyUntilNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyUntilNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyUntilNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyUntilNode >> do [
	^ do
]

{ #category : #generated }
RpRubyUntilNode >> do: aToken [
	do := aToken
]

{ #category : #generated }
RpRubyUntilNode >> end [
	^ end
]

{ #category : #generated }
RpRubyUntilNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyUntilNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyUntilNode >> nodeVariables [
	^ #(condition)
]

{ #category : #generated }
RpRubyUntilNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyUntilNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyUntilNode >> tokenVariables [
	^ #(do end until)
]

{ #category : #generated }
RpRubyUntilNode >> until [
	^ until
]

{ #category : #generated }
RpRubyUntilNode >> until: aToken [
	until := aToken
]
