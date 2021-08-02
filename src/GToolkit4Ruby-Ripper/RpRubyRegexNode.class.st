Class {
	#name : #RpRubyRegexNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRegexNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRegex: self
]

{ #category : #generated }
RpRubyRegexNode >> otherVariables [
	^ #(parts)
]

{ #category : #generated }
RpRubyRegexNode >> parts [
	^ parts
]

{ #category : #generated }
RpRubyRegexNode >> parts: anObject [
	self setParent: self parts to: nil.
	parts := anObject.
	self setParent: self parts to: self
]
