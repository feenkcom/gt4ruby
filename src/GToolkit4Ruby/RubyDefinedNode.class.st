Class {
	#name : #RubyDefinedNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'variable',
		'defined',
		'left',
		'right'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyDefinedNode >> defined [
	^ defined
]

{ #category : #generated }
RubyDefinedNode >> defined: aToken [
	defined := aToken
]

{ #category : #generated }
RubyDefinedNode >> left [
	^ left
]

{ #category : #generated }
RubyDefinedNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyDefinedNode >> nodeVariables [
	^ #(variable)
]

{ #category : #generated }
RubyDefinedNode >> right [
	^ right
]

{ #category : #generated }
RubyDefinedNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyDefinedNode >> tokenVariables [
	^ #(defined left right)
]

{ #category : #generated }
RubyDefinedNode >> variable [
	^ variable
]

{ #category : #generated }
RubyDefinedNode >> variable: aNode [
	self variable notNil ifTrue: [ self variable parent: nil ].
	variable := aNode.
	self variable notNil ifTrue: [ self variable parent: self ]
]
