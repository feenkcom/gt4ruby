Class {
	#name : #RubyFileNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements',
		'comments',
		'embeddedDocumentItems'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyFileNode >> acceptVisitor: aVisitor [
	^ aVisitor visitFile: self
]

{ #category : #generated }
RubyFileNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyFileNode >> compositeTokenVariables [
	^ #(embeddedDocumentItems)
]

{ #category : #generated }
RubyFileNode >> embeddedDocumentItems [
	^ embeddedDocumentItems
]

{ #category : #generated }
RubyFileNode >> embeddedDocumentItems: anOrderedCollection [
	embeddedDocumentItems := anOrderedCollection
]

{ #category : #generated }
RubyFileNode >> initialize [
	super initialize.
	embeddedDocumentItems := OrderedCollection new: 2.
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
