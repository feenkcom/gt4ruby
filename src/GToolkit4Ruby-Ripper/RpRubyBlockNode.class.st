Class {
	#name : #RpRubyBlockNode,
	#superclass : #RpRubyProgramNode,
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
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyBlockNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBlock: self
]

{ #category : #generated }
RpRubyBlockNode >> body [
	^ body
]

{ #category : #generated }
RpRubyBlockNode >> body: aNode [
	self body notNil ifTrue: [ self body parent: nil ].
	body := aNode.
	self body notNil ifTrue: [ self body parent: self ]
]

{ #category : #generated }
RpRubyBlockNode >> compositeTokenVariables [
	^ #(semicolons)
]

{ #category : #generated }
RpRubyBlockNode >> do [
	^ do
]

{ #category : #generated }
RpRubyBlockNode >> do: aToken [
	do := aToken
]

{ #category : #generated }
RpRubyBlockNode >> end [
	^ end
]

{ #category : #generated }
RpRubyBlockNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyBlockNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyBlockNode >> left [
	^ left
]

{ #category : #generated }
RpRubyBlockNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyBlockNode >> nodeVariables [
	^ #(body variables)
]

{ #category : #generated }
RpRubyBlockNode >> otherVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyBlockNode >> right [
	^ right
]

{ #category : #generated }
RpRubyBlockNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyBlockNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RpRubyBlockNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RpRubyBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyBlockNode >> statements: anObject [
	self setParent: self statements to: nil.
	statements := anObject.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyBlockNode >> tokenVariables [
	^ #(do end left right)
]

{ #category : #generated }
RpRubyBlockNode >> variables [
	^ variables
]

{ #category : #generated }
RpRubyBlockNode >> variables: aNode [
	self variables notNil ifTrue: [ self variables parent: nil ].
	variables := aNode.
	self variables notNil ifTrue: [ self variables parent: self ]
]
