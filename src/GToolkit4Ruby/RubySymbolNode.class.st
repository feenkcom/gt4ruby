Class {
	#name : #RubySymbolNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'colon'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubySymbolNode >> colon [
	^ colon
]

{ #category : #generated }
RubySymbolNode >> colon: aToken [
	colon := aToken
]

{ #category : #generated }
RubySymbolNode >> name [
	^ name
]

{ #category : #generated }
RubySymbolNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubySymbolNode >> tokenVariables [
	^ #(colon name)
]
