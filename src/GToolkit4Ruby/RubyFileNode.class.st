Class {
	#name : #RubyFileNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements',
		'comments'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyFileNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyFileNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyFileNode >> statements [
	^ statements
]

{ #category : #generated }
RubyFileNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]
