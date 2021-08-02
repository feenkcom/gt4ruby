Class {
	#name : #RpRubyRetryNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'retry'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRetryNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRetry: self
]

{ #category : #generated }
RpRubyRetryNode >> retry [
	^ retry
]

{ #category : #generated }
RpRubyRetryNode >> retry: aToken [
	retry := aToken
]

{ #category : #generated }
RpRubyRetryNode >> tokenVariables [
	^ #(retry)
]
