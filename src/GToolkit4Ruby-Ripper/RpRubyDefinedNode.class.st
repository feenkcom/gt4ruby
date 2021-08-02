Class {
	#name : #RpRubyDefinedNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'variable',
		'defined',
		'left',
		'right'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyDefinedNode >> acceptVisitor: aVisitor [
	^ aVisitor visitDefined: self
]

{ #category : #generated }
RpRubyDefinedNode >> defined [
	^ defined
]

{ #category : #generated }
RpRubyDefinedNode >> defined: aToken [
	defined := aToken
]

{ #category : #generated }
RpRubyDefinedNode >> left [
	^ left
]

{ #category : #generated }
RpRubyDefinedNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyDefinedNode >> nodeVariables [
	^ #(variable)
]

{ #category : #generated }
RpRubyDefinedNode >> right [
	^ right
]

{ #category : #generated }
RpRubyDefinedNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyDefinedNode >> tokenVariables [
	^ #(defined left right)
]

{ #category : #generated }
RpRubyDefinedNode >> variable [
	^ variable
]

{ #category : #generated }
RpRubyDefinedNode >> variable: aNode [
	self variable notNil ifTrue: [ self variable parent: nil ].
	variable := aNode.
	self variable notNil ifTrue: [ self variable parent: self ]
]
