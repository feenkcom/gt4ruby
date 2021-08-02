Class {
	#name : #RpRubyBlockArgVariableNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'amp'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyBlockArgVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBlockArgVariable: self
]

{ #category : #generated }
RpRubyBlockArgVariableNode >> amp [
	^ amp
]

{ #category : #generated }
RpRubyBlockArgVariableNode >> amp: aToken [
	amp := aToken
]

{ #category : #generated }
RpRubyBlockArgVariableNode >> name [
	^ name
]

{ #category : #generated }
RpRubyBlockArgVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyBlockArgVariableNode >> tokenVariables [
	^ #(amp name)
]

{ #category : #accessing }
RpRubyBlockArgVariableNode >> variableName [
	^ name ifNil: [ '&' ] ifNotNil: [ '&' , name source ]
]
