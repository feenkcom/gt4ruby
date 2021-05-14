Class {
	#name : #RubyAliasNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'newName',
		'oldName',
		'alias'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyAliasNode >> alias [
	^ alias
]

{ #category : #generated }
RubyAliasNode >> alias: aToken [
	alias := aToken
]

{ #category : #generated }
RubyAliasNode >> newName [
	^ newName
]

{ #category : #generated }
RubyAliasNode >> newName: anObject [
	self setParent: self newName to: nil.
	newName := anObject.
	self setParent: self newName to: self
]

{ #category : #generated }
RubyAliasNode >> oldName [
	^ oldName
]

{ #category : #generated }
RubyAliasNode >> oldName: anObject [
	self setParent: self oldName to: nil.
	oldName := anObject.
	self setParent: self oldName to: self
]

{ #category : #generated }
RubyAliasNode >> otherVariables [
	^ #(newName oldName)
]

{ #category : #generated }
RubyAliasNode >> tokenVariables [
	^ #(alias)
]
