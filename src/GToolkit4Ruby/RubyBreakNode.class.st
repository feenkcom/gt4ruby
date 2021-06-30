Class {
	#name : #RubyBreakNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'break',
		'value'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyBreakNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBreak: self
]

{ #category : #generated }
RubyBreakNode >> break [
	^ break
]

{ #category : #generated }
RubyBreakNode >> break: aToken [
	break := aToken
]

{ #category : #generated }
RubyBreakNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RubyBreakNode >> tokenVariables [
	^ #(break)
]

{ #category : #generated }
RubyBreakNode >> value [
	^ value
]

{ #category : #generated }
RubyBreakNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
