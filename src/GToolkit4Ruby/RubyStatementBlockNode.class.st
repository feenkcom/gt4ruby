Class {
	#name : #RubyStatementBlockNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements',
		'rescue',
		'ensure',
		'rescueElse',
		'semicolons'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyStatementBlockNode >> compositeNodeVariables [
	^ #(rescueElse statements)
]

{ #category : #generated }
RubyStatementBlockNode >> compositeTokenVariables [
	^ #(semicolons)
]

{ #category : #generated }
RubyStatementBlockNode >> ensure [
	^ ensure
]

{ #category : #generated }
RubyStatementBlockNode >> ensure: aNode [
	self ensure notNil ifTrue: [ self ensure parent: nil ].
	ensure := aNode.
	self ensure notNil ifTrue: [ self ensure parent: self ]
]

{ #category : #generated }
RubyStatementBlockNode >> initialize [
	super initialize.
	semicolons := OrderedCollection new: 2.
	statements := OrderedCollection new: 2.
	rescueElse := OrderedCollection new: 2
]

{ #category : #generated }
RubyStatementBlockNode >> nodeVariables [
	^ #(ensure rescue)
]

{ #category : #generated }
RubyStatementBlockNode >> rescue [
	^ rescue
]

{ #category : #generated }
RubyStatementBlockNode >> rescue: aNode [
	self rescue notNil ifTrue: [ self rescue parent: nil ].
	rescue := aNode.
	self rescue notNil ifTrue: [ self rescue parent: self ]
]

{ #category : #generated }
RubyStatementBlockNode >> rescueElse [
	^ rescueElse
]

{ #category : #generated }
RubyStatementBlockNode >> rescueElse: anOrderedCollection [
	self setParent: self rescueElse to: nil.
	rescueElse := anOrderedCollection.
	self setParent: self rescueElse to: self
]

{ #category : #generated }
RubyStatementBlockNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
RubyStatementBlockNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]

{ #category : #generated }
RubyStatementBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RubyStatementBlockNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]
