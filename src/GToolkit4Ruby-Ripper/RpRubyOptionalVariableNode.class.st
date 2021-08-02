Class {
	#name : #RpRubyOptionalVariableNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyOptionalVariableNode >> acceptVisitor: aVisitor [
	^ aVisitor visitOptionalVariable: self
]

{ #category : #generated }
RpRubyOptionalVariableNode >> equals [
	^ equals
]

{ #category : #generated }
RpRubyOptionalVariableNode >> equals: aToken [
	equals := aToken
]

{ #category : #generated }
RpRubyOptionalVariableNode >> name [
	^ name
]

{ #category : #generated }
RpRubyOptionalVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyOptionalVariableNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyOptionalVariableNode >> tokenVariables [
	^ #(equals name)
]

{ #category : #generated }
RpRubyOptionalVariableNode >> value [
	^ value
]

{ #category : #generated }
RpRubyOptionalVariableNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]

{ #category : #accessing }
RpRubyOptionalVariableNode >> variableName [
	^ name source
]
