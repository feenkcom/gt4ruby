Class {
	#name : #RpRubyRangeNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'from',
		'to',
		'dots',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRangeNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRange: self
]

{ #category : #generated }
RpRubyRangeNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyRangeNode >> dots [
	^ dots
]

{ #category : #generated }
RpRubyRangeNode >> dots: aToken [
	dots := aToken
]

{ #category : #generated }
RpRubyRangeNode >> from [
	^ from
]

{ #category : #generated }
RpRubyRangeNode >> from: aNode [
	self from notNil ifTrue: [ self from parent: nil ].
	from := aNode.
	self from notNil ifTrue: [ self from parent: self ]
]

{ #category : #generated }
RpRubyRangeNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyRangeNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyRangeNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyRangeNode >> nodeVariables [
	^ #(from to)
]

{ #category : #generated }
RpRubyRangeNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyRangeNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyRangeNode >> to [
	^ to
]

{ #category : #generated }
RpRubyRangeNode >> to: aNode [
	self to notNil ifTrue: [ self to parent: nil ].
	to := aNode.
	self to notNil ifTrue: [ self to parent: self ]
]

{ #category : #generated }
RpRubyRangeNode >> tokenVariables [
	^ #(dots)
]
