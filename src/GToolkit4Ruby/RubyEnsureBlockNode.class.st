Class {
	#name : #RubyEnsureBlockNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'statements',
		'ensure'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyEnsureBlockNode >> acceptVisitor: aVisitor [
	^ aVisitor visitEnsureBlock: self
]

{ #category : #generated }
RubyEnsureBlockNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyEnsureBlockNode >> ensure [
	^ ensure
]

{ #category : #generated }
RubyEnsureBlockNode >> ensure: aToken [
	ensure := aToken
]

{ #category : #generated }
RubyEnsureBlockNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyEnsureBlockNode >> statements [
	^ statements
]

{ #category : #generated }
RubyEnsureBlockNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyEnsureBlockNode >> tokenVariables [
	^ #(ensure)
]
