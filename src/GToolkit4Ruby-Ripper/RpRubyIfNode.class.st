Class {
	#name : #RpRubyIfNode,
	#superclass : #RpRubyProgramNode,
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
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyIfNode >> acceptVisitor: aVisitor [
	^ aVisitor visitIf: self
]

{ #category : #generated }
RpRubyIfNode >> compositeNodeVariables [
	^ #(thenStatements)
]

{ #category : #generated }
RpRubyIfNode >> compositeTokenVariables [
	^ #(leftParens rightParens semicolons)
]

{ #category : #generated }
RpRubyIfNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyIfNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyIfNode >> else [
	^ else
]

{ #category : #generated }
RpRubyIfNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RpRubyIfNode >> end [
	^ end
]

{ #category : #generated }
RpRubyIfNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyIfNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
RpRubyIfNode >> ifToken: aToken [
	ifToken := aToken
]

{ #category : #generated }
RpRubyIfNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
	thenStatements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyIfNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyIfNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyIfNode >> nodeVariables [
	^ #(condition else)
]

{ #category : #generated }
RpRubyIfNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyIfNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyIfNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RpRubyIfNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RpRubyIfNode >> then [
	^ then
]

{ #category : #generated }
RpRubyIfNode >> then: aToken [
	then := aToken
]

{ #category : #generated }
RpRubyIfNode >> thenStatements [
	^ thenStatements
]

{ #category : #generated }
RpRubyIfNode >> thenStatements: anOrderedCollection [
	self setParent: self thenStatements to: nil.
	thenStatements := anOrderedCollection.
	self setParent: self thenStatements to: self
]

{ #category : #generated }
RpRubyIfNode >> tokenVariables [
	^ #(end ifToken then)
]
