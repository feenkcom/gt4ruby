Class {
	#name : #RubyBlockNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variables',
		'statements',
		'left',
		'right',
		'body',
		'do',
		'end',
		'semicolons'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyBlockNode >> body [
	^ body
]

{ #category : #generated }
RubyBlockNode >> body: aNode [
	self body notNil ifTrue: [ self body parent: nil ].
	body := aNode.
	self body notNil ifTrue: [ self body parent: self ]
]

{ #category : #generated }
RubyBlockNode >> compositeTokenVariables [
	^ #(semicolons)
]

{ #category : #generated }
RubyBlockNode >> do [
	^ do
]

{ #category : #generated }
RubyBlockNode >> do: aToken [
	do := aToken
]

{ #category : #generated }
RubyBlockNode >> end [
	^ end
]

{ #category : #generated }
RubyBlockNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyBlockNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2
]

{ #category : #generated }
RubyBlockNode >> left [
	^ left
]

{ #category : #generated }
RubyBlockNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyBlockNode >> nodeVariables [
	^ #(body variables)
]

{ #category : #generated }
RubyBlockNode >> otherVariables [
	^ #(statements)
]

{ #category : #generated }
RubyBlockNode >> right [
	^ right
]

{ #category : #generated }
RubyBlockNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyBlockNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RubyBlockNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RubyBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RubyBlockNode >> statements: anObject [
	self setParent: self statements to: nil.
	statements := anObject.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyBlockNode >> tokenVariables [
	^ #(do end left right)
]

{ #category : #generated }
RubyBlockNode >> variables [
	^ variables
]

{ #category : #generated }
RubyBlockNode >> variables: aNode [
	self variables notNil ifTrue: [ self variables parent: nil ].
	variables := aNode.
	self variables notNil ifTrue: [ self variables parent: self ]
]
