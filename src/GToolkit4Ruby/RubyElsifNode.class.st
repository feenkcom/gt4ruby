Class {
	#name : #RubyElsifNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statements',
		'elsif',
		'else'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyElsifNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyElsifNode >> condition [
	^ condition
]

{ #category : #generated }
RubyElsifNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyElsifNode >> else [
	^ else
]

{ #category : #generated }
RubyElsifNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RubyElsifNode >> elsif [
	^ elsif
]

{ #category : #generated }
RubyElsifNode >> elsif: aToken [
	elsif := aToken
]

{ #category : #generated }
RubyElsifNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyElsifNode >> nodeVariables [
	^ #(condition else)
]

{ #category : #generated }
RubyElsifNode >> statements [
	^ statements
]

{ #category : #generated }
RubyElsifNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyElsifNode >> tokenVariables [
	^ #(elsif)
]
