Class {
	#name : #RubyWhenNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'conditions',
		'statements',
		'next',
		'when',
		'commas',
		'then'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyWhenNode >> acceptVisitor: aVisitor [
	^ aVisitor visitWhen: self
]

{ #category : #generated }
RubyWhenNode >> commas [
	^ commas
]

{ #category : #generated }
RubyWhenNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyWhenNode >> compositeNodeVariables [
	^ #(conditions)
]

{ #category : #generated }
RubyWhenNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyWhenNode >> conditions [
	^ conditions
]

{ #category : #generated }
RubyWhenNode >> conditions: anOrderedCollection [
	self setParent: self conditions to: nil.
	conditions := anOrderedCollection.
	self setParent: self conditions to: self
]

{ #category : #generated }
RubyWhenNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	conditions := OrderedCollection new: 2
]

{ #category : #generated }
RubyWhenNode >> next [
	^ next
]

{ #category : #generated }
RubyWhenNode >> next: aNode [
	self next notNil ifTrue: [ self next parent: nil ].
	next := aNode.
	self next notNil ifTrue: [ self next parent: self ]
]

{ #category : #generated }
RubyWhenNode >> nodeVariables [
	^ #(next)
]

{ #category : #generated }
RubyWhenNode >> otherVariables [
	^ #(statements)
]

{ #category : #generated }
RubyWhenNode >> statements [
	^ statements
]

{ #category : #generated }
RubyWhenNode >> statements: anObject [
	self setParent: self statements to: nil.
	statements := anObject.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyWhenNode >> then [
	^ then
]

{ #category : #generated }
RubyWhenNode >> then: aToken [
	then := aToken
]

{ #category : #generated }
RubyWhenNode >> tokenVariables [
	^ #(then when)
]

{ #category : #generated }
RubyWhenNode >> when [
	^ when
]

{ #category : #generated }
RubyWhenNode >> when: aToken [
	when := aToken
]
