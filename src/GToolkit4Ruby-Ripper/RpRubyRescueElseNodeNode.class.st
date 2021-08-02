Class {
	#name : #RpRubyRescueElseNodeNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'statements',
		'else'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRescueElseNodeNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRescueElseNode: self
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> else [
	^ else
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> else: aToken [
	else := aToken
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyRescueElseNodeNode >> tokenVariables [
	^ #(else)
]
