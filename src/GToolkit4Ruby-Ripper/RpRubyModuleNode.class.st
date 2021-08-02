Class {
	#name : #RpRubyModuleNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'block',
		'module',
		'end'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyModuleNode >> acceptVisitor: aVisitor [
	^ aVisitor visitModule: self
]

{ #category : #generated }
RpRubyModuleNode >> block [
	^ block
]

{ #category : #generated }
RpRubyModuleNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RpRubyModuleNode >> end [
	^ end
]

{ #category : #generated }
RpRubyModuleNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyModuleNode >> module [
	^ module
]

{ #category : #generated }
RpRubyModuleNode >> module: aToken [
	module := aToken
]

{ #category : #generated }
RpRubyModuleNode >> name [
	^ name
]

{ #category : #generated }
RpRubyModuleNode >> name: aNode [
	self name notNil ifTrue: [ self name parent: nil ].
	name := aNode.
	self name notNil ifTrue: [ self name parent: self ]
]

{ #category : #generated }
RpRubyModuleNode >> nodeVariables [
	^ #(block name)
]

{ #category : #generated }
RpRubyModuleNode >> tokenVariables [
	^ #(end module)
]
