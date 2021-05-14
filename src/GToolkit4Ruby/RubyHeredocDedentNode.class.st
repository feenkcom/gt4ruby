Class {
	#name : #RubyHeredocDedentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'string',
		'start',
		'end',
		'leftParens',
		'rightParens'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyHeredocDedentNode >> compositeTokenVariables [
	^ #(leftParens rightParens)
]

{ #category : #generated }
RubyHeredocDedentNode >> end [
	^ end
]

{ #category : #generated }
RubyHeredocDedentNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyHeredocDedentNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2
]

{ #category : #generated }
RubyHeredocDedentNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
RubyHeredocDedentNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
RubyHeredocDedentNode >> nodeVariables [
	^ #(string)
]

{ #category : #generated }
RubyHeredocDedentNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
RubyHeredocDedentNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]

{ #category : #generated }
RubyHeredocDedentNode >> start [
	^ start
]

{ #category : #generated }
RubyHeredocDedentNode >> start: aToken [
	start := aToken
]

{ #category : #generated }
RubyHeredocDedentNode >> string [
	^ string
]

{ #category : #generated }
RubyHeredocDedentNode >> string: aNode [
	self string notNil ifTrue: [ self string parent: nil ].
	string := aNode.
	self string notNil ifTrue: [ self string parent: self ]
]

{ #category : #generated }
RubyHeredocDedentNode >> tokenVariables [
	^ #(end start)
]
