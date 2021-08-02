Class {
	#name : #RpRubyUnlessNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'thenStatements',
		'unlessToken',
		'end',
		'else'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyUnlessNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUnless: self
]

{ #category : #generated }
RpRubyUnlessNode >> compositeNodeVariables [
	^ #(thenStatements)
]

{ #category : #generated }
RpRubyUnlessNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyUnlessNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyUnlessNode >> else [
	^ else
]

{ #category : #generated }
RpRubyUnlessNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RpRubyUnlessNode >> end [
	^ end
]

{ #category : #generated }
RpRubyUnlessNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyUnlessNode >> initialize [
	super initialize.
	thenStatements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyUnlessNode >> nodeVariables [
	^ #(condition else)
]

{ #category : #generated }
RpRubyUnlessNode >> thenStatements [
	^ thenStatements
]

{ #category : #generated }
RpRubyUnlessNode >> thenStatements: anOrderedCollection [
	self setParent: self thenStatements to: nil.
	thenStatements := anOrderedCollection.
	self setParent: self thenStatements to: self
]

{ #category : #generated }
RpRubyUnlessNode >> tokenVariables [
	^ #(end unlessToken)
]

{ #category : #generated }
RpRubyUnlessNode >> unlessToken [
	^ unlessToken
]

{ #category : #generated }
RpRubyUnlessNode >> unlessToken: aToken [
	unlessToken := aToken
]
