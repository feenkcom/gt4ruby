Class {
	#name : #RubyModuleNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'block',
		'module',
		'end'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyModuleNode >> block [
	^ block
]

{ #category : #generated }
RubyModuleNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RubyModuleNode >> end [
	^ end
]

{ #category : #generated }
RubyModuleNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyModuleNode >> module [
	^ module
]

{ #category : #generated }
RubyModuleNode >> module: aToken [
	module := aToken
]

{ #category : #generated }
RubyModuleNode >> name [
	^ name
]

{ #category : #generated }
RubyModuleNode >> name: aNode [
	self name notNil ifTrue: [ self name parent: nil ].
	name := aNode.
	self name notNil ifTrue: [ self name parent: self ]
]

{ #category : #generated }
RubyModuleNode >> nodeVariables [
	^ #(block name)
]

{ #category : #generated }
RubyModuleNode >> tokenVariables [
	^ #(end module)
]
