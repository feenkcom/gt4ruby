Class {
	#name : #RubyHashNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'associations',
		'left',
		'right'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyHashNode >> associations [
	^ associations
]

{ #category : #generated }
RubyHashNode >> associations: anOrderedCollection [
	self setParent: self associations to: nil.
	associations := anOrderedCollection.
	self setParent: self associations to: self
]

{ #category : #generated }
RubyHashNode >> compositeNodeVariables [
	^ #(associations)
]

{ #category : #generated }
RubyHashNode >> initialize [
	super initialize.
	associations := OrderedCollection new: 2
]

{ #category : #generated }
RubyHashNode >> left [
	^ left
]

{ #category : #generated }
RubyHashNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyHashNode >> right [
	^ right
]

{ #category : #generated }
RubyHashNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyHashNode >> tokenVariables [
	^ #(left right)
]
