Class {
	#name : #RpRubyAliasNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'newName',
		'oldName',
		'alias'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyAliasNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAlias: self
]

{ #category : #generated }
RpRubyAliasNode >> alias [
	^ alias
]

{ #category : #generated }
RpRubyAliasNode >> alias: aToken [
	alias := aToken
]

{ #category : #generated }
RpRubyAliasNode >> newName [
	^ newName
]

{ #category : #generated }
RpRubyAliasNode >> newName: anObject [
	self setParent: self newName to: nil.
	newName := anObject.
	self setParent: self newName to: self
]

{ #category : #generated }
RpRubyAliasNode >> oldName [
	^ oldName
]

{ #category : #generated }
RpRubyAliasNode >> oldName: anObject [
	self setParent: self oldName to: nil.
	oldName := anObject.
	self setParent: self oldName to: self
]

{ #category : #generated }
RpRubyAliasNode >> otherVariables [
	^ #(newName oldName)
]

{ #category : #generated }
RpRubyAliasNode >> tokenVariables [
	^ #(alias)
]
