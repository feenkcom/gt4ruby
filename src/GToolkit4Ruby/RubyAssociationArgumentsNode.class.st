Class {
	#name : #RubyAssociationArgumentsNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'args',
		'commas'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyAssociationArgumentsNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAssociationArguments: self
]

{ #category : #generated }
RubyAssociationArgumentsNode >> args [
	^ args
]

{ #category : #generated }
RubyAssociationArgumentsNode >> args: anOrderedCollection [
	self setParent: self args to: nil.
	args := anOrderedCollection.
	self setParent: self args to: self
]

{ #category : #generated }
RubyAssociationArgumentsNode >> commas [
	^ commas
]

{ #category : #generated }
RubyAssociationArgumentsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RubyAssociationArgumentsNode >> compositeNodeVariables [
	^ #(args)
]

{ #category : #generated }
RubyAssociationArgumentsNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RubyAssociationArgumentsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	args := OrderedCollection new: 2
]
