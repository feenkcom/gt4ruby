Class {
	#name : #RubyIfModNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'condition',
		'statement',
		'ifToken'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyIfModNode >> condition [
	^ condition
]

{ #category : #generated }
RubyIfModNode >> condition: aNode [
	self condition notNil ifTrue: [ self condition parent: nil ].
	condition := aNode.
	self condition notNil ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
RubyIfModNode >> ifToken [
	^ ifToken
]

{ #category : #generated }
RubyIfModNode >> ifToken: aToken [
	ifToken := aToken
]

{ #category : #generated }
RubyIfModNode >> nodeVariables [
	^ #(condition statement)
]

{ #category : #generated }
RubyIfModNode >> statement [
	^ statement
]

{ #category : #generated }
RubyIfModNode >> statement: aNode [
	self statement notNil ifTrue: [ self statement parent: nil ].
	statement := aNode.
	self statement notNil ifTrue: [ self statement parent: self ]
]

{ #category : #generated }
RubyIfModNode >> tokenVariables [
	^ #(ifToken)
]
