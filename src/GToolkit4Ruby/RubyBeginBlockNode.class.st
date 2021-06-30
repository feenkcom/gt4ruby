Class {
	#name : #RubyBeginBlockNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'block',
		'begin',
		'end'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyBeginBlockNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBeginBlock: self
]

{ #category : #generated }
RubyBeginBlockNode >> begin [
	^ begin
]

{ #category : #generated }
RubyBeginBlockNode >> begin: aToken [
	begin := aToken
]

{ #category : #generated }
RubyBeginBlockNode >> block [
	^ block
]

{ #category : #generated }
RubyBeginBlockNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RubyBeginBlockNode >> end [
	^ end
]

{ #category : #generated }
RubyBeginBlockNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyBeginBlockNode >> nodeVariables [
	^ #(block)
]

{ #category : #generated }
RubyBeginBlockNode >> tokenVariables [
	^ #(begin end)
]
