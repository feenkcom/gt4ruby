Class {
	#name : #RubyRestVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'star'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyRestVariableNode >> name [
	^ name
]

{ #category : #generated }
RubyRestVariableNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyRestVariableNode >> star [
	^ star
]

{ #category : #generated }
RubyRestVariableNode >> star: aToken [
	star := aToken
]

{ #category : #generated }
RubyRestVariableNode >> tokenVariables [
	^ #(name star)
]
