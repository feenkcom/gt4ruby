Class {
	#name : #RubyRegexNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyRegexNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRegex: self
]

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