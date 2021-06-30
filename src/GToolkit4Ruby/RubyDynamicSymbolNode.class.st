Class {
	#name : #RubyDynamicSymbolNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyDynamicSymbolNode >> acceptVisitor: aVisitor [
	^ aVisitor visitDynamicSymbol: self
]

{ #category : #generated }
RubyDynamicSymbolNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RubyDynamicSymbolNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2
]

{ #category : #generated }
RubyDynamicSymbolNode >> parts [
	^ parts
]

{ #category : #generated }
RubyDynamicSymbolNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]
