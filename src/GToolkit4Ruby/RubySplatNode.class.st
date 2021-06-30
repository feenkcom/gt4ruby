Class {
	#name : #RubySplatNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'star'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubySplatNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSplat: self
]

{ #category : #generated }
RubySplatNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubySplatNode >> star [
	^ star
]

{ #category : #generated }
RubySplatNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RubySplatNode >> tokenVariables [
	^ #(star)
]

{ #category : #generated }
RubySplatNode >> value [
	^ value
]

{ #category : #generated }
RubySplatNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
