Class {
	#name : #RpRubyConstPathNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'receiver',
		'separator',
		'name'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyConstPathNode >> acceptVisitor: aVisitor [
	^ aVisitor visitConstPath: self
]

{ #category : #generated }
RpRubyConstPathNode >> name [
	^ name
]

{ #category : #generated }
RpRubyConstPathNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RpRubyConstPathNode >> nodeVariables [
	^ #(receiver)
]

{ #category : #generated }
RpRubyConstPathNode >> receiver [
	^ receiver
]

{ #category : #generated }
RpRubyConstPathNode >> receiver: aNode [
	self receiver notNil ifTrue: [ self receiver parent: nil ].
	receiver := aNode.
	self receiver notNil ifTrue: [ self receiver parent: self ]
]

{ #category : #generated }
RpRubyConstPathNode >> separator [
	^ separator
]

{ #category : #generated }
RpRubyConstPathNode >> separator: aToken [
	separator := aToken
]

{ #category : #generated }
RpRubyConstPathNode >> tokenVariables [
	^ #(name separator)
]
