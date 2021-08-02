Class {
	#name : #RpRubyConcatStringNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyConcatStringNode >> acceptVisitor: aVisitor [
	^ aVisitor visitConcatString: self
]

{ #category : #generated }
RpRubyConcatStringNode >> left [
	^ left
]

{ #category : #generated }
RpRubyConcatStringNode >> left: aNode [
	self left notNil ifTrue: [ self left parent: nil ].
	left := aNode.
	self left notNil ifTrue: [ self left parent: self ]
]

{ #category : #generated }
RpRubyConcatStringNode >> nodeVariables [
	^ #(left right)
]

{ #category : #generated }
RpRubyConcatStringNode >> right [
	^ right
]

{ #category : #generated }
RpRubyConcatStringNode >> right: aNode [
	self right notNil ifTrue: [ self right parent: nil ].
	right := aNode.
	self right notNil ifTrue: [ self right parent: self ]
]
