Class {
	#name : #RubyPartNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'part'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyPartNode >> acceptVisitor: aVisitor [
	^ aVisitor visitPart: self
]

{ #category : #generated }
RubyPartNode >> part [
	^ part
]

{ #category : #generated }
RubyPartNode >> part: aToken [
	part := aToken
]

{ #category : #generated }
RubyPartNode >> tokenVariables [
	^ #(part)
]
