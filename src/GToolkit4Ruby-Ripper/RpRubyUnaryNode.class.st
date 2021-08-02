Class {
	#name : #RpRubyUnaryNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value',
		'operator',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyUnaryNode >> acceptVisitor: aVisitor [
	^ aVisitor visitUnary: self
]

{ #category : #generated }
RpRubyUnaryNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyUnaryNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyUnaryNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyUnaryNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyUnaryNode >> nodeVariables [
	^ #(value)
]

{ #category : #generated }
RpRubyUnaryNode >> operator [
	^ operator
]

{ #category : #generated }
RpRubyUnaryNode >> operator: aToken [
	operator := aToken
]

{ #category : #generated }
RpRubyUnaryNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyUnaryNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyUnaryNode >> tokenVariables [
	^ #(operator)
]

{ #category : #generated }
RpRubyUnaryNode >> value [
	^ value
]

{ #category : #generated }
RpRubyUnaryNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
