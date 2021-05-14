Class {
	#name : #RubyHeredocDedentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'string',
		'start',
		'end'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyHeredocDedentNode >> end [
	^ end
]

{ #category : #generated }
RubyHeredocDedentNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyHeredocDedentNode >> nodeVariables [
	^ #(string)
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
