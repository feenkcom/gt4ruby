Class {
	#name : #RubyLambdaNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'block',
		'parameters',
		'arrow',
		'left',
		'right'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyLambdaNode >> arrow [
	^ arrow
]

{ #category : #generated }
RubyLambdaNode >> arrow: aToken [
	arrow := aToken
]

{ #category : #generated }
RubyLambdaNode >> block [
	^ block
]

{ #category : #generated }
RubyLambdaNode >> block: anOrderedCollection [
	self setParent: self block to: nil.
	block := anOrderedCollection.
	self setParent: self block to: self
]

{ #category : #generated }
RubyLambdaNode >> compositeNodeVariables [
	^ #(block)
]

{ #category : #generated }
RubyLambdaNode >> initialize [
	super initialize.
	block := OrderedCollection new: 2
]

{ #category : #generated }
RubyLambdaNode >> left [
	^ left
]

{ #category : #generated }
RubyLambdaNode >> left: anObject [
	self setParent: self left to: nil.
	left := anObject.
	self setParent: self left to: self
]

{ #category : #generated }
RubyLambdaNode >> otherVariables [
	^ #(left parameters)
]

{ #category : #generated }
RubyLambdaNode >> parameters [
	^ parameters
]

{ #category : #generated }
RubyLambdaNode >> parameters: anObject [
	self setParent: self parameters to: nil.
	parameters := anObject.
	self setParent: self parameters to: self
]

{ #category : #generated }
RubyLambdaNode >> right [
	^ right
]

{ #category : #generated }
RubyLambdaNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyLambdaNode >> tokenVariables [
	^ #(arrow right)
]
