Class {
	#name : #RpRubyWhenNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'conditions',
		'statements',
		'next',
		'when',
		'commas',
		'then'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyWhenNode >> acceptVisitor: aVisitor [
	^ aVisitor visitWhen: self
]

{ #category : #generated }
RpRubyWhenNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyWhenNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyWhenNode >> compositeNodeVariables [
	^ #(conditions)
]

{ #category : #generated }
RpRubyWhenNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyWhenNode >> conditions [
	^ conditions
]

{ #category : #generated }
RpRubyWhenNode >> conditions: anOrderedCollection [
	self setParent: self conditions to: nil.
	conditions := anOrderedCollection.
	self setParent: self conditions to: self
]

{ #category : #generated }
RpRubyWhenNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	conditions := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyWhenNode >> next [
	^ next
]

{ #category : #generated }
RpRubyWhenNode >> next: aNode [
	self next notNil ifTrue: [ self next parent: nil ].
	next := aNode.
	self next notNil ifTrue: [ self next parent: self ]
]

{ #category : #generated }
RpRubyWhenNode >> nodeVariables [
	^ #(next)
]

{ #category : #generated }
RpRubyWhenNode >> otherVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyWhenNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyWhenNode >> statements: anObject [
	self setParent: self statements to: nil.
	statements := anObject.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyWhenNode >> then [
	^ then
]

{ #category : #generated }
RpRubyWhenNode >> then: aToken [
	then := aToken
]

{ #category : #generated }
RpRubyWhenNode >> tokenVariables [
	^ #(then when)
]

{ #category : #generated }
RpRubyWhenNode >> when [
	^ when
]

{ #category : #generated }
RpRubyWhenNode >> when: aToken [
	when := aToken
]
