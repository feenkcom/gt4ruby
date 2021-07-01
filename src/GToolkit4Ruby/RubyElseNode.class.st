Class {
	#name : #RubyElseNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements',
		'else'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyElseNode >> acceptVisitor: aVisitor [
	^ aVisitor visitElse: self
]

{ #category : #generated }
RubyElseNode >> else [
	^ else
]

{ #category : #generated }
RubyElseNode >> else: aToken [
	else := aToken
]

{ #category : #generated }
RubyElseNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyElseNode >> otherVariables [
	^ #(statements)
]

{ #category : #generated }
RubyElseNode >> statements [
	^ statements
]

{ #category : #generated }
RubyElseNode >> statements: anObject [
	self setParent: self statements to: nil.
	statements := anObject.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyElseNode >> tokenVariables [
	^ #(else)
]