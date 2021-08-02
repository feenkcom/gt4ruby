Class {
	#name : #RpRubyXStringNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyXStringNode >> acceptVisitor: aVisitor [
	^ aVisitor visitXString: self
]

{ #category : #generated }
RpRubyXStringNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RpRubyXStringNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyXStringNode >> parts [
	^ parts
]

{ #category : #generated }
RpRubyXStringNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]
