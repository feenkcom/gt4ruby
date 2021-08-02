Class {
	#name : #RpRubyMethodNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'block',
		'params',
		'module',
		'defToken',
		'period',
		'name',
		'endToken'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyMethodNode >> acceptVisitor: aVisitor [
	^ aVisitor visitMethod: self
]

{ #category : #generated }
RpRubyMethodNode >> block [
	^ block
]

{ #category : #generated }
RpRubyMethodNode >> block: aNode [
	self block notNil ifTrue: [ self block parent: nil ].
	block := aNode.
	self block notNil ifTrue: [ self block parent: self ]
]

{ #category : #generated }
RpRubyMethodNode >> defToken [
	^ defToken
]

{ #category : #generated }
RpRubyMethodNode >> defToken: aToken [
	defToken := aToken
]

{ #category : #generated }
RpRubyMethodNode >> endToken [
	^ endToken
]

{ #category : #generated }
RpRubyMethodNode >> endToken: aToken [
	endToken := aToken
]

{ #category : #generated }
RpRubyMethodNode >> initialize [
	super initialize.
	params := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyMethodNode >> module [
	^ module
]

{ #category : #generated }
RpRubyMethodNode >> module: aNode [
	self module notNil ifTrue: [ self module parent: nil ].
	module := aNode.
	self module notNil ifTrue: [ self module parent: self ]
]

{ #category : #generated }
RpRubyMethodNode >> name [
	^ name
]

{ #category : #generated }
RpRubyMethodNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyMethodNode >> nodeVariables [
	^ #(block module)
]

{ #category : #generated }
RpRubyMethodNode >> otherVariables [
	^ #(params)
]

{ #category : #generated }
RpRubyMethodNode >> params [
	^ params
]

{ #category : #generated }
RpRubyMethodNode >> params: anOrderedCollection [
	self setParent: self params to: nil.
	params := anOrderedCollection.
	self setParent: self params to: self
]

{ #category : #generated }
RpRubyMethodNode >> period [
	^ period
]

{ #category : #generated }
RpRubyMethodNode >> period: aToken [
	period := aToken
]

{ #category : #generated }
RpRubyMethodNode >> tokenVariables [
	^ #(defToken endToken name period)
]
