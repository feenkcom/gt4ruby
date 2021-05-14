Class {
	#name : #RubyIfNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'thenStatements',
		'ifToken',
		'end',
		'else'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyIfNode >> compositeNodeVariables [
	^ #(thenStatements)
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
	thenStatements := OrderedCollection new: 2
]

{ #category : #generated }
RubyIfNode >> nodeVariables [
	^ #(condition else)
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
	^ #(end ifToken)
]
