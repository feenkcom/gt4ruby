Class {
	#name : #RpRubyFileNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'statements',
		'comments',
		'embeddedDocumentItems'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyFileNode >> acceptVisitor: aVisitor [
	^ aVisitor visitFile: self
]

{ #category : #generated }
RpRubyFileNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyFileNode >> compositeTokenVariables [
	^ #(embeddedDocumentItems)
]

{ #category : #generated }
RpRubyFileNode >> embeddedDocumentItems [
	^ embeddedDocumentItems
]

{ #category : #generated }
RpRubyFileNode >> embeddedDocumentItems: anOrderedCollection [
	embeddedDocumentItems := anOrderedCollection
]

{ #category : #generated }
RpRubyFileNode >> initialize [
	super initialize.
	embeddedDocumentItems := OrderedCollection new: 2.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyFileNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyFileNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]
