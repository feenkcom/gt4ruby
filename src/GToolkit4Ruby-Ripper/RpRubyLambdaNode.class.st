Class {
	#name : #RpRubyLambdaNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'block',
		'parameters',
		'arrow',
		'left',
		'right'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyLambdaNode >> acceptVisitor: aVisitor [
	^ aVisitor visitLambda: self
]

{ #category : #generated }
RpRubyLambdaNode >> arrow [
	^ arrow
]

{ #category : #generated }
RpRubyLambdaNode >> arrow: aToken [
	arrow := aToken
]

{ #category : #generated }
RpRubyLambdaNode >> block [
	^ block
]

{ #category : #generated }
RpRubyLambdaNode >> block: anOrderedCollection [
	self setParent: self block to: nil.
	block := anOrderedCollection.
	self setParent: self block to: self
]

{ #category : #generated }
RpRubyLambdaNode >> initialize [
	super initialize.
	block := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyLambdaNode >> left [
	^ left
]

{ #category : #generated }
RpRubyLambdaNode >> left: anObject [
	self setParent: self left to: nil.
	left := anObject.
	self setParent: self left to: self
]

{ #category : #generated }
RpRubyLambdaNode >> otherVariables [
	^ #(left parameters block)
]

{ #category : #generated }
RpRubyLambdaNode >> parameters [
	^ parameters
]

{ #category : #generated }
RpRubyLambdaNode >> parameters: anObject [
	self setParent: self parameters to: nil.
	parameters := anObject.
	self setParent: self parameters to: self
]

{ #category : #generated }
RpRubyLambdaNode >> right [
	^ right
]

{ #category : #generated }
RpRubyLambdaNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyLambdaNode >> tokenVariables [
	^ #(arrow right)
]
