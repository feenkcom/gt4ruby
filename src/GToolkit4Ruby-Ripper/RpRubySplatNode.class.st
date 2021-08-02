Class {
	#name : #RpRubySplatNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value',
		'star'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubySplatNode >> acceptVisitor: aVisitor [
	^ aVisitor visitSplat: self
]

{ #category : #generated }
RpRubySplatNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubySplatNode >> star [
	^ star
]

{ #category : #generated }
RpRubySplatNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RpRubySplatNode >> tokenVariables [
	^ #(star)
]

{ #category : #generated }
RpRubySplatNode >> value [
	^ value
]

{ #category : #generated }
RpRubySplatNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
