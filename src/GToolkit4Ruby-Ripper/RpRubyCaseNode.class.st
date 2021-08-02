Class {
	#name : #RpRubyCaseNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'value',
		'when',
		'case',
		'end'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyCaseNode >> acceptVisitor: aVisitor [
	^ aVisitor visitCase: self
]

{ #category : #generated }
RpRubyCaseNode >> case [
	^ case
]

{ #category : #generated }
RpRubyCaseNode >> case: aToken [
	case := aToken
]

{ #category : #generated }
RpRubyCaseNode >> end [
	^ end
]

{ #category : #generated }
RpRubyCaseNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyCaseNode >> nodeVariables [
	^ #(value when)
]

{ #category : #generated }
RpRubyCaseNode >> tokenVariables [
	^ #(case end)
]

{ #category : #generated }
RpRubyCaseNode >> value [
	^ value
]

{ #category : #generated }
RpRubyCaseNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]

{ #category : #generated }
RpRubyCaseNode >> when [
	^ when
]

{ #category : #generated }
RpRubyCaseNode >> when: aNode [
	self when notNil ifTrue: [ self when parent: nil ].
	when := aNode.
	self when notNil ifTrue: [ self when parent: self ]
]
