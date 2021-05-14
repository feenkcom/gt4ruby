Class {
	#name : #RubyPartNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'part'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyPartNode >> part [
	^ part
]

{ #category : #generated }
RubyPartNode >> part: aToken [
	part := aToken
]

{ #category : #generated }
RubyPartNode >> tokenVariables [
	^ #(part)
]
