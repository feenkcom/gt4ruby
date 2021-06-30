Class {
	#name : #RubyRestVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'star'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyRestVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRestVariable: self
]

{ #category : #generated }
RubyRestVariableNode >> name [
	^ name
]

{ #category : #generated }
RubyRestVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyRestVariableNode >> star [
	^ star
]

{ #category : #generated }
RubyRestVariableNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RubyRestVariableNode >> tokenVariables [
	^ #(name star)
]
