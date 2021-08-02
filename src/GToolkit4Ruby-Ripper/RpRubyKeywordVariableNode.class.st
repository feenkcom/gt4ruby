Class {
	#name : #RpRubyKeywordVariableNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'label',
		'value'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyKeywordVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitKeywordVariable: self
]

{ #category : #generated }
RpRubyKeywordVariableNode >> label [
	^ label
]

{ #category : #generated }
RpRubyKeywordVariableNode >> label: aNode [
	self label notNil ifTrue: [ self label parent: nil ].
	label := aNode.
	self label notNil ifTrue: [ self label parent: self ]
]

{ #category : #generated }
RpRubyKeywordVariableNode >> nodeVariables [
	^ #(label value)
]

{ #category : #generated }
RpRubyKeywordVariableNode >> value [
	^ value
]

{ #category : #generated }
RpRubyKeywordVariableNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]

{ #category : #accessing }
RpRubyKeywordVariableNode >> variableName [
	^ value ifNil: [ label source allButLast ] ifNotNil: [ value source ]
]
