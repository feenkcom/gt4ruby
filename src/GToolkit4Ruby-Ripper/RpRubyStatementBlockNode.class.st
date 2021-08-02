Class {
	#name : #RpRubyStatementBlockNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'statements',
		'rescue',
		'ensure',
		'rescueElse',
		'semicolons'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyStatementBlockNode >> acceptVisitor: aVisitor [
	^ aVisitor visitStatementBlock: self
]

{ #category : #generated }
RpRubyStatementBlockNode >> compositeNodeVariables [
	^ #(rescueElse statements)
]

{ #category : #generated }
RpRubyStatementBlockNode >> compositeTokenVariables [
	^ #(semicolons)
]

{ #category : #generated }
RpRubyStatementBlockNode >> ensure [
	^ ensure
]

{ #category : #generated }
RpRubyStatementBlockNode >> ensure: aNode [
	self ensure notNil ifTrue: [ self ensure parent: nil ].
	ensure := aNode.
	self ensure notNil ifTrue: [ self ensure parent: self ]
]

{ #category : #generated }
RpRubyStatementBlockNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2.
	statements := OrderedCollection new: 2.
	rescueElse := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyStatementBlockNode >> nodeVariables [
	^ #(ensure rescue)
]

{ #category : #generated }
RpRubyStatementBlockNode >> rescue [
	^ rescue
]

{ #category : #generated }
RpRubyStatementBlockNode >> rescue: aNode [
	self rescue notNil ifTrue: [ self rescue parent: nil ].
	rescue := aNode.
	self rescue notNil ifTrue: [ self rescue parent: self ]
]

{ #category : #generated }
RpRubyStatementBlockNode >> rescueElse [
	^ rescueElse
]

{ #category : #generated }
RpRubyStatementBlockNode >> rescueElse: anOrderedCollection [
	self setParent: self rescueElse to: nil.
	rescueElse := anOrderedCollection.
	self setParent: self rescueElse to: self
]

{ #category : #generated }
RpRubyStatementBlockNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RpRubyStatementBlockNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RpRubyStatementBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyStatementBlockNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]
