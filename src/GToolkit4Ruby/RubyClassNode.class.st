Class {
	#name : #RubyClassNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name',
		'superclass',
		'body',
		'classToken',
		'lt',
		'end'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyClassNode >> acceptVisitor: aVisitor [
	^ aVisitor visitClass: self
]

{ #category : #generated }
RubyClassNode >> body [
	^ body
]

{ #category : #generated }
RubyClassNode >> body: aNode [
	self body notNil ifTrue: [ self body parent: nil ].
	body := aNode.
	self body notNil ifTrue: [ self body parent: self ]
]

{ #category : #generated }
RubyClassNode >> classToken [
	^ classToken
]

{ #category : #generated }
RubyClassNode >> classToken: aToken [
	classToken := aToken
]

{ #category : #generated }
RubyClassNode >> end [
	^ end
]

{ #category : #generated }
RubyClassNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RubyClassNode >> lt [
	^ lt
]

{ #category : #generated }
RubyClassNode >> lt: aToken [
	lt := aToken
]

{ #category : #generated }
RubyClassNode >> name [
	^ name
]

{ #category : #generated }
RubyClassNode >> name: aNode [
	self name notNil ifTrue: [ self name parent: nil ].
	name := aNode.
	self name notNil ifTrue: [ self name parent: self ]
]

{ #category : #generated }
RubyClassNode >> nodeVariables [
	^ #(body name superclass)
]

{ #category : #generated }
RubyClassNode >> superclass [
	^ superclass
]

{ #category : #generated }
RubyClassNode >> superclass: aNode [
	self superclass notNil ifTrue: [ self superclass parent: nil ].
	superclass := aNode.
	self superclass notNil ifTrue: [ self superclass parent: self ]
]

{ #category : #generated }
RubyClassNode >> tokenVariables [
	^ #(classToken end lt)
]
