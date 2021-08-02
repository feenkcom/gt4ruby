Class {
	#name : #RpRubyElsifNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'condition',
		'statements',
		'elsif',
		'else'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyElsifNode >> acceptVisitor: aVisitor [
	^ aVisitor visitElsif: self
]

{ #category : #generated }
RpRubyElsifNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyElsifNode >> condition [
	^ condition
]

{ #category : #generated }
RpRubyElsifNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RpRubyElsifNode >> else [
	^ else
]

{ #category : #generated }
RpRubyElsifNode >> else: aNode [
	self else notNil ifTrue: [ self else parent: nil ].
	else := aNode.
	self else notNil ifTrue: [ self else parent: self ]
]

{ #category : #generated }
RpRubyElsifNode >> elsif [
	^ elsif
]

{ #category : #generated }
RpRubyElsifNode >> elsif: aToken [
	elsif := aToken
]

{ #category : #generated }
RpRubyElsifNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyElsifNode >> nodeVariables [
	^ #(condition else)
]

{ #category : #generated }
RpRubyElsifNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyElsifNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyElsifNode >> tokenVariables [
	^ #(elsif)
]
