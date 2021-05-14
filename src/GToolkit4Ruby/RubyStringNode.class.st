Class {
	#name : #RubyStringNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyStringNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #generated }
RubyStringNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2
]

{ #category : #generated }
RubyStringNode >> parts [
	^ parts
]

{ #category : #generated }
RubyStringNode >> parts: anOrderedCollection [
	self setParent: self parts to: nil.
	parts := anOrderedCollection.
	self setParent: self parts to: self
]
