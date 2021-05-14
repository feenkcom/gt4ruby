Class {
	#name : #RubyRescueElseNodeNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements',
		'else'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyRescueElseNodeNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyRescueElseNodeNode >> else [
	^ else
]

{ #category : #generated }
RubyRescueElseNodeNode >> else: aToken [
	else := aToken
]

{ #category : #generated }
RubyRescueElseNodeNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyRescueElseNodeNode >> statements [
	^ statements
]

{ #category : #generated }
RubyRescueElseNodeNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyRescueElseNodeNode >> tokenVariables [
	^ #(else)
]
