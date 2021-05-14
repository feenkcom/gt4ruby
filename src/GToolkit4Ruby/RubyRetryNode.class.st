Class {
	#name : #RubyRetryNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'retry'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyRetryNode >> retry [
	^ retry
]

{ #category : #generated }
RubyRetryNode >> retry: aToken [
	retry := aToken
]

{ #category : #generated }
RubyRetryNode >> tokenVariables [
	^ #(retry)
]
