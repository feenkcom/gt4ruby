Class {
	#name : #RubyXStringNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyXStringNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RubyXStringNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2
]

{ #category : #generated }
RubyXStringNode >> parts [
	^ parts
]

{ #category : #generated }
RubyXStringNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]
