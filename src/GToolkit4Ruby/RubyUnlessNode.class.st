Class {
	#name : #RubyUnlessNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'thenStatements',
		'unlessToken',
		'end',
		'else'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyUnlessNode >> compositeNodeVariables [
	^ #(thenStatements)
]

{ #category : #generated }
RubyUnlessNode >> condition [
	^ condition
]

{ #category : #generated }
RubyUnlessNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyUnlessNode >> else [
	^ else
]

{ #category : #generated }
RubyUnlessNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RubyUnlessNode >> end [
	^ end
]

{ #category : #generated }
RubyUnlessNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyUnlessNode >> initialize [
	super initialize.
	thenStatements := OrderedCollection new: 2
]

{ #category : #generated }
RubyUnlessNode >> nodeVariables [
	^ #(condition else)
]

{ #category : #generated }
RubyUnlessNode >> thenStatements [
	^ thenStatements
]

{ #category : #generated }
RubyUnlessNode >> thenStatements: anOrderedCollection [
	self setParent: self thenStatements to: nil.
	thenStatements := anOrderedCollection.
	self setParent: self thenStatements to: self
]

{ #category : #generated }
RubyUnlessNode >> tokenVariables [
	^ #(end unlessToken)
]

{ #category : #generated }
RubyUnlessNode >> unlessToken [
	^ unlessToken
]

{ #category : #generated }
RubyUnlessNode >> unlessToken: aToken [
	unlessToken := aToken
]
