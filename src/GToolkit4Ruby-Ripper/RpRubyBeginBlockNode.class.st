Class {
	#name : #RpRubyBeginBlockNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'block',
		'begin',
		'end'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyBeginBlockNode >> acceptVisitor: aVisitor [
	^ aVisitor visitBeginBlock: self
]

{ #category : #generated }
RpRubyBeginBlockNode >> begin [
	^ begin
]

{ #category : #generated }
RpRubyBeginBlockNode >> begin: aToken [
	begin := aToken
]

{ #category : #generated }
RpRubyBeginBlockNode >> block [
	^ block
]

{ #category : #generated }
RpRubyBeginBlockNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RpRubyBeginBlockNode >> end [
	^ end
]

{ #category : #generated }
RpRubyBeginBlockNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyBeginBlockNode >> nodeVariables [
	^ #(block)
]

{ #category : #generated }
RpRubyBeginBlockNode >> tokenVariables [
	^ #(begin end)
]
