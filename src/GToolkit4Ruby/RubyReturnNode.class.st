Class {
	#name : #RubyReturnNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'return',
		'values'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyReturnNode >> compositeNodeVariables [
	^ #(values)
]

{ #category : #generated }
RubyReturnNode >> initialize [
	super initialize.
	values := OrderedCollection new: 2
]

{ #category : #generated }
RubyReturnNode >> return [
	^ return
]

{ #category : #generated }
RubyReturnNode >> return: aToken [
	return := aToken
]

{ #category : #generated }
RubyReturnNode >> tokenVariables [
	^ #(return)
]

{ #category : #generated }
RubyReturnNode >> values [
	^ values
]

{ #category : #generated }
RubyReturnNode >> values: anOrderedCollection [
	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]
