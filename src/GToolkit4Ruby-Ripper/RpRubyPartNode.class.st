Class {
	#name : #RpRubyPartNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'part'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyPartNode >> acceptVisitor: aVisitor [
	^ aVisitor visitPart: self
]

{ #category : #generated }
RpRubyPartNode >> part [
	^ part
]

{ #category : #generated }
RpRubyPartNode >> part: aToken [
	part := aToken
]

{ #category : #generated }
RpRubyPartNode >> tokenVariables [
	^ #(part)
]
