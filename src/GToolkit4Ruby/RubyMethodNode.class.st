Class {
	#name : #RubyMethodNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'block',
		'params',
		'module',
		'defToken',
		'period',
		'name',
		'endToken'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyMethodNode >> acceptVisitor: aVisitor [
	^ aVisitor visitMethod: self
]

{ #category : #generated }
RubyMethodNode >> block [
	^ block
]

{ #category : #generated }
RubyMethodNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RubyMethodNode >> defToken [
	^ defToken
]

{ #category : #generated }
RubyMethodNode >> defToken: aToken [
	defToken := aToken
]

{ #category : #generated }
RubyMethodNode >> endToken [
	^ endToken
]

{ #category : #generated }
RubyMethodNode >> endToken: aToken [
	endToken := aToken
]

{ #category : #generated }
RubyMethodNode >> initialize [
	super initialize.
	params := OrderedCollection new: 2
]

{ #category : #generated }
RubyMethodNode >> module [
	^ module
]

{ #category : #generated }
RubyMethodNode >> module: aNode [
	self module notNil ifTrue: [ self module parent: nil ].
	module := aNode.
	self module notNil ifTrue: [ self module parent: self ]
]

{ #category : #generated }
RubyMethodNode >> name [
	^ name
]

{ #category : #generated }
RubyMethodNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyMethodNode >> nodeVariables [
	^ #(block module)
]

{ #category : #generated }
RubyMethodNode >> otherVariables [
	^ #(params)
]

{ #category : #generated }
RubyMethodNode >> params [
	^ params
]

{ #category : #generated }
RubyMethodNode >> params: anOrderedCollection [
	self setParent: self params to: nil.
	params := anOrderedCollection.
	self setParent: self params to: self
]

{ #category : #generated }
RubyMethodNode >> period [
	^ period
]

{ #category : #generated }
RubyMethodNode >> period: aToken [
	period := aToken
]

{ #category : #generated }
RubyMethodNode >> tokenVariables [
	^ #(defToken endToken name period)
]
