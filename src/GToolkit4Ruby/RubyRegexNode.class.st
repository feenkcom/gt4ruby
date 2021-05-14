Class {
	#name : #RubyRegexNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyRegexNode >> otherVariables [
	^ #(parts)
]

{ #category : #generated }
RubyRegexNode >> parts [
	^ parts
]

{ #category : #generated }
RubyRegexNode >> parts: anObject [
	self setParent: self parts to: nil.
	parts := anObject.
	self setParent: self parts to: self
]
