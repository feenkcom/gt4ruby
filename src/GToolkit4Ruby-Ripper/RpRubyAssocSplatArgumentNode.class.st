Class {
	#name : #RpRubyAssocSplatArgumentNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'argument',
		'splat'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAssocSplatArgument: self
]

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> argument [
	^ argument
]

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> argument: aNode [
	self argument notNil ifTrue: [ self argument parent: nil ].
	argument := aNode.
	self argument notNil ifTrue: [ self argument parent: self ]
]

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> nodeVariables [
	^ #(argument)
]

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> splat [
	^ splat
]

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> splat: aToken [
	splat := aToken
]

{ #category : #generated }
RpRubyAssocSplatArgumentNode >> tokenVariables [
	^ #(splat)
]
