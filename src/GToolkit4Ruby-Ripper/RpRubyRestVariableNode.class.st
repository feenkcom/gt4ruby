Class {
	#name : #RpRubyRestVariableNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'star'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRestVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRestVariable: self
]

{ #category : #generated }
RpRubyRestVariableNode >> name [
	^ name
]

{ #category : #generated }
RpRubyRestVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyRestVariableNode >> star [
	^ star
]

{ #category : #generated }
RpRubyRestVariableNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RpRubyRestVariableNode >> tokenVariables [
	^ #(name star)
]

{ #category : #accessing }
RpRubyRestVariableNode >> variableName [
	^ name ifNil: [ '*' ] ifNotNil: [ '*' , name source ]
]
