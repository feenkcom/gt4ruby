Class {
	#name : #RubyCaseNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'value',
		'when',
		'case',
		'end'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyCaseNode >> acceptVisitor: aVisitor [
	^ aVisitor visitCase: self
]

{ #category : #generated }
RubyCaseNode >> case [
	^ case
]

{ #category : #generated }
RubyCaseNode >> case: aToken [
	case := aToken
]

{ #category : #generated }
RubyCaseNode >> end [
	^ end
]

{ #category : #generated }
RubyCaseNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyCaseNode >> nodeVariables [
	^ #(value when)
]

{ #category : #generated }
RubyCaseNode >> tokenVariables [
	^ #(case end)
]

{ #category : #generated }
RubyCaseNode >> value [
	^ value
]

{ #category : #generated }
RubyCaseNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]

{ #category : #generated }
RubyCaseNode >> when [
	^ when
]

{ #category : #generated }
RubyCaseNode >> when: aNode [
	self when notNil ifTrue: [ self when parent: nil ].
	when := aNode.
	self when notNil ifTrue: [ self when parent: self ]
]
