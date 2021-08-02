Class {
	#name : #RpRubyDynamicSymbolNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyDynamicSymbolNode >> acceptVisitor: aVisitor [
	^ aVisitor visitDynamicSymbol: self
]

{ #category : #generated }
RpRubyDynamicSymbolNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RpRubyDynamicSymbolNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyDynamicSymbolNode >> parts [
	^ parts
]

{ #category : #generated }
RpRubyDynamicSymbolNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]
