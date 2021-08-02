Class {
	#name : #RpRubyElseNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'statements',
		'else'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyElseNode >> acceptVisitor: aVisitor [
	^ aVisitor visitElse: self
]

{ #category : #generated }
RpRubyElseNode >> else [
	^ else
]

{ #category : #generated }
RpRubyElseNode >> else: aToken [
	else := aToken
]

{ #category : #generated }
RpRubyElseNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyElseNode >> otherVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyElseNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyElseNode >> statements: anObject [
	self setParent: self statements to: nil.
	statements := anObject.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyElseNode >> tokenVariables [
	^ #(else)
]
