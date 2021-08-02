Class {
	#name : #RpRubyBreakNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'break',
		'value'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyBreakNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBreak: self
]

{ #category : #generated }
RpRubyBreakNode >> break [
	^ break
]

{ #category : #generated }
RpRubyBreakNode >> break: aToken [
	break := aToken
]

{ #category : #generated }
RpRubyBreakNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyBreakNode >> tokenVariables [
	^ #(break)
]

{ #category : #generated }
RpRubyBreakNode >> value [
	^ value
]

{ #category : #generated }
RpRubyBreakNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
