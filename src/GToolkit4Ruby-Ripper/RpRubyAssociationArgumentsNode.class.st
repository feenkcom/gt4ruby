Class {
	#name : #RpRubyAssociationArgumentsNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'args',
		'commas'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyAssociationArgumentsNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAssociationArguments: self
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> args [
	^ args
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> args: anOrderedCollection [
	self setParent: self args to: nil.
	args := anOrderedCollection.
	self setParent: self args to: self
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> commas [
	^ commas
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> compositeNodeVariables [
	^ #(args)
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> compositeTokenVariables [
	^ #(commas)
]

{ #category : #generated }
RpRubyAssociationArgumentsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
	args := OrderedCollection new: 2
]
