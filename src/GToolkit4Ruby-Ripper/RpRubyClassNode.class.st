Class {
	#name : #RpRubyClassNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'name',
		'superclass',
		'body',
		'classToken',
		'lt',
		'end'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyClassNode >> acceptVisitor: aVisitor [
	^ aVisitor visitClass: self
]

{ #category : #generated }
RpRubyClassNode >> body [
	^ body
]

{ #category : #generated }
RpRubyClassNode >> body: aNode [
	self body notNil ifTrue: [ self body parent: nil ].
	body := aNode.
	self body notNil ifTrue: [ self body parent: self ]
]

{ #category : #generated }
RpRubyClassNode >> classToken [
	^ classToken
]

{ #category : #generated }
RpRubyClassNode >> classToken: aToken [
	classToken := aToken
]

{ #category : #generated }
RpRubyClassNode >> end [
	^ end
]

{ #category : #generated }
RpRubyClassNode >> end: aToken [
	end := aToken
]

{ #category : #generated }
RpRubyClassNode >> lt [
	^ lt
]

{ #category : #generated }
RpRubyClassNode >> lt: aToken [
	lt := aToken
]

{ #category : #generated }
RpRubyClassNode >> name [
	^ name
]

{ #category : #generated }
RpRubyClassNode >> name: aNode [
	self name notNil ifTrue: [ self name parent: nil ].
	name := aNode.
	self name notNil ifTrue: [ self name parent: self ]
]

{ #category : #generated }
RpRubyClassNode >> nodeVariables [
	^ #(body name superclass)
]

{ #category : #generated }
RpRubyClassNode >> superclass [
	^ superclass
]

{ #category : #generated }
RpRubyClassNode >> superclass: aNode [
	self superclass notNil ifTrue: [ self superclass parent: nil ].
	superclass := aNode.
	self superclass notNil ifTrue: [ self superclass parent: self ]
]

{ #category : #generated }
RpRubyClassNode >> tokenVariables [
	^ #(classToken end lt)
]
