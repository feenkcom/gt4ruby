Class {
	#name : #RubyVariableNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'name'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyVariableNode >> name [
	^ name
]

{ #category : #generated }
RubyVariableNode >> name: anObject [
	self setParent: self name to: nil.
	name := anObject.
	self setParent: self name to: self
]

{ #category : #generated }
RubyVariableNode >> otherVariables [
	^ #(name)
]
