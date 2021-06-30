Class {
	#name : #RubyKeywordVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'label',
		'value'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyKeywordVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitKeywordVariable: self
]

{ #category : #generated }
RubyKeywordVariableNode >> label [
	^ label
]

{ #category : #generated }
RubyKeywordVariableNode >> label: aNode [
	self label notNil ifTrue: [ self label parent: nil ].
	label := aNode.
	self label notNil ifTrue: [ self label parent: self ]
]

{ #category : #generated }
RubyKeywordVariableNode >> nodeVariables [
	^ #(label value)
]

{ #category : #generated }
RubyKeywordVariableNode >> value [
	^ value
]

{ #category : #generated }
RubyKeywordVariableNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
