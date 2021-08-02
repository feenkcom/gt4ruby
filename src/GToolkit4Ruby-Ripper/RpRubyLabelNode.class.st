Class {
	#name : #RpRubyLabelNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyLabelNode >> acceptVisitor: aVisitor [
	^ aVisitor visitLabel: self
]

{ #category : #generated }
RpRubyLabelNode >> tokenVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyLabelNode >> value [
	^ value
]

{ #category : #generated }
RpRubyLabelNode >> value: aToken [
	value := aToken
]
