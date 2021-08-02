Class {
	#name : #RpRubyHeredocDedentNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'string',
		'start',
		'end',
		'leftParens',
		'rightParens'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyHeredocDedentNode >> acceptVisitor: aVisitor [
	^ aVisitor visitHeredocDedent: self
]

{ #category : #generated }
RpRubyHeredocDedentNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RpRubyHeredocDedentNode >> end [
	^ end
]

{ #category : #generated }
RpRubyHeredocDedentNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyHeredocDedentNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyHeredocDedentNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RpRubyHeredocDedentNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RpRubyHeredocDedentNode >> nodeVariables [
	^ #(string)
]

{ #category : #generated }
RpRubyHeredocDedentNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RpRubyHeredocDedentNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RpRubyHeredocDedentNode >> start [
	^ start
]

{ #category : #generated }
RpRubyHeredocDedentNode >> start: aToken [
	start := aToken
]

{ #category : #generated }
RpRubyHeredocDedentNode >> string [
	^ string
]

{ #category : #generated }
RpRubyHeredocDedentNode >> string: aNode [
	self string notNil ifTrue: [ self string parent: nil ].
	string := aNode.
	self string notNil ifTrue: [ self string parent: self ]
]

{ #category : #generated }
RpRubyHeredocDedentNode >> tokenVariables [
	^ #(end start)
]
