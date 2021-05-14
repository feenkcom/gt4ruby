Class {
	#name : #RubyConcatStringNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyConcatStringNode >> left [
	^ left
]

{ #category : #generated }
RubyConcatStringNode >> left: aNode [
	self left notNil ifTrue: [ self left parent: nil ].
	left := aNode.
	self left notNil ifTrue: [ self left parent: self ]
]

{ #category : #generated }
RubyConcatStringNode >> nodeVariables [
	^ #(left right)
]

{ #category : #generated }
RubyConcatStringNode >> right [
	^ right
]

{ #category : #generated }
RubyConcatStringNode >> right: aNode [
	self right notNil ifTrue: [ self right parent: nil ].
	right := aNode.
	self right notNil ifTrue: [ self right parent: self ]
]
