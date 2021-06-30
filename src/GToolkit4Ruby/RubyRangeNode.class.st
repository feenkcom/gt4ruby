Class {
	#name : #RubyRangeNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'from',
		'to',
		'dots',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyRangeNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRange: self
]

{ #category : #generated }
RubyRangeNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyRangeNode >> dots [
	^ dots
]

{ #category : #generated }
RubyRangeNode >> dots: aToken [
	dots := aToken
]

{ #category : #generated }
RubyRangeNode >> from [
	^ from
]

{ #category : #generated }
RubyRangeNode >> from: aNode [
	self from notNil ifTrue: [ self from parent: nil ].
	from := aNode.
	self from notNil ifTrue: [ self from parent: self ]
]

{ #category : #generated }
RubyRangeNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyRangeNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyRangeNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyRangeNode >> nodeVariables [
	^ #(from to)
]

{ #category : #generated }
RubyRangeNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyRangeNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyRangeNode >> to [
	^ to
]

{ #category : #generated }
RubyRangeNode >> to: aNode [
	self to notNil ifTrue: [ self to parent: nil ].
	to := aNode.
	self to notNil ifTrue: [ self to parent: self ]
]

{ #category : #generated }
RubyRangeNode >> tokenVariables [
	^ #(dots)
]
