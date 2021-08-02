Class {
	#name : #RpRubyExcludeRangeNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'from',
		'to',
		'dots'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyExcludeRangeNode >> acceptVisitor: aVisitor [
	^ aVisitor visitExcludeRange: self
]

{ #category : #generated }
RpRubyExcludeRangeNode >> dots [
	^ dots
]

{ #category : #generated }
RpRubyExcludeRangeNode >> dots: aToken [
	dots := aToken
]

{ #category : #generated }
RpRubyExcludeRangeNode >> from [
	^ from
]

{ #category : #generated }
RpRubyExcludeRangeNode >> from: aNode [
	self from notNil ifTrue: [ self from parent: nil ].
	from := aNode.
	self from notNil ifTrue: [ self from parent: self ]
]

{ #category : #generated }
RpRubyExcludeRangeNode >> nodeVariables [
	^ #(from to)
]

{ #category : #generated }
RpRubyExcludeRangeNode >> to [
	^ to
]

{ #category : #generated }
RpRubyExcludeRangeNode >> to: aNode [
	self to notNil ifTrue: [ self to parent: nil ].
	to := aNode.
	self to notNil ifTrue: [ self to parent: self ]
]

{ #category : #generated }
RpRubyExcludeRangeNode >> tokenVariables [
	^ #(dots)
]
