Class {
	#name : #RubyExcludeRangeNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'from',
		'to',
		'dots'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyExcludeRangeNode >> dots [
	^ dots
]

{ #category : #generated }
RubyExcludeRangeNode >> dots: aToken [
	dots := aToken
]

{ #category : #generated }
RubyExcludeRangeNode >> from [
	^ from
]

{ #category : #generated }
RubyExcludeRangeNode >> from: aNode [
	self from notNil ifTrue: [ self from parent: nil ].
	from := aNode.
	self from notNil ifTrue: [ self from parent: self ]
]

{ #category : #generated }
RubyExcludeRangeNode >> nodeVariables [
	^ #(from to)
]

{ #category : #generated }
RubyExcludeRangeNode >> to [
	^ to
]

{ #category : #generated }
RubyExcludeRangeNode >> to: aNode [
	self to notNil ifTrue: [ self to parent: nil ].
	to := aNode.
	self to notNil ifTrue: [ self to parent: self ]
]

{ #category : #generated }
RubyExcludeRangeNode >> tokenVariables [
	^ #(dots)
]
