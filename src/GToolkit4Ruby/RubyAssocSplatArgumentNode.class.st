Class {
	#name : #RubyAssocSplatArgumentNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'argument',
		'splat'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyAssocSplatArgumentNode >> argument [
	^ argument
]

{ #category : #generated }
RubyAssocSplatArgumentNode >> argument: aNode [
	self argument notNil ifTrue: [ self argument parent: nil ].
	argument := aNode.
	self argument notNil ifTrue: [ self argument parent: self ]
]

{ #category : #generated }
RubyAssocSplatArgumentNode >> nodeVariables [
	^ #(argument)
]

{ #category : #generated }
RubyAssocSplatArgumentNode >> splat [
	^ splat
]

{ #category : #generated }
RubyAssocSplatArgumentNode >> splat: aToken [
	splat := aToken
]

{ #category : #generated }
RubyAssocSplatArgumentNode >> tokenVariables [
	^ #(splat)
]
