Class {
	#name : #RubyIfNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'thenStatements',
		'ifToken',
		'end',
		'else',
		'then',
		'leftParens',
		'rightParens',
		'semicolons'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyIfNode >> compositeNodeVariables [
	^ #(thenStatements)
]

{ #category : #generated }
RubyIfNode >> compositeTokenVariables [
	^ #(leftParens rightParens semicolons)
]

{ #category : #generated }
RubyIfNode >> condition [
	^ condition
]

{ #category : #generated }
RubyIfNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyIfNode >> else [
	^ else
]

{ #category : #generated }
RubyIfNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RubyIfNode >> end [
	^ end
]

{ #category : #generated }
RubyIfNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyIfNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
RubyIfNode >> ifToken: aToken [
	ifToken := aToken
]

{ #category : #generated }
RubyIfNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
	thenStatements := OrderedCollection new: 2
]

{ #category : #generated }
RubyIfNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyIfNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyIfNode >> nodeVariables [
	^ #(condition else)
]

{ #category : #generated }
RubyIfNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyIfNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyIfNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RubyIfNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RubyIfNode >> then [
	^ then
]

{ #category : #generated }
RubyIfNode >> then: aToken [
	then := aToken
]

{ #category : #generated }
RubyIfNode >> thenStatements [
	^ thenStatements
]

{ #category : #generated }
RubyIfNode >> thenStatements: anOrderedCollection [
	self setParent: self thenStatements to: nil.
	thenStatements := anOrderedCollection.
	self setParent: self thenStatements to: self
]

{ #category : #generated }
RubyIfNode >> tokenVariables [
	^ #(end ifToken then)
]
