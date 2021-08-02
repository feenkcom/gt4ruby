Class {
	#name : #RpRubyEnsureBlockNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'statements',
		'ensure'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyEnsureBlockNode >> acceptVisitor: aVisitor [
	^ aVisitor visitEnsureBlock: self
]

{ #category : #generated }
RpRubyEnsureBlockNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyEnsureBlockNode >> ensure [
	^ ensure
]

{ #category : #generated }
RpRubyEnsureBlockNode >> ensure: aToken [
	ensure := aToken
]

{ #category : #generated }
RpRubyEnsureBlockNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyEnsureBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyEnsureBlockNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyEnsureBlockNode >> tokenVariables [
	^ #(ensure)
]
