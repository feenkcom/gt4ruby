Class {
	#name : #RubyConstPathNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'receiver',
		'separator',
		'name'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyConstPathNode >> name [
	^ name
]

{ #category : #generated }
RubyConstPathNode >> name: aToken [
	name := aToken
]

{ #category : #generated }
RubyConstPathNode >> nodeVariables [
	^ #(receiver)
]

{ #category : #generated }
RubyConstPathNode >> receiver [
	^ receiver
]

{ #category : #generated }
RubyConstPathNode >> receiver: aNode [
	self receiver notNil ifTrue: [ self receiver parent: nil ].
	receiver := aNode.
	self receiver notNil ifTrue: [ self receiver parent: self ]
]

{ #category : #generated }
RubyConstPathNode >> separator [
	^ separator
]

{ #category : #generated }
RubyConstPathNode >> separator: aToken [
	separator := aToken
]

{ #category : #generated }
RubyConstPathNode >> tokenVariables [
	^ #(name separator)
]
