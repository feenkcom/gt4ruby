Class {
	#name : #RubyAssociationNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'key',
		'value',
		'arrow'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyAssociationNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAssociation: self
]

{ #category : #generated }
RubyAssociationNode >> arrow [
	^ arrow
]

{ #category : #generated }
RubyAssociationNode >> arrow: aToken [
	arrow := aToken
]

{ #category : #generated }
RubyAssociationNode >> key [
	^ key
]

{ #category : #generated }
RubyAssociationNode >> key: aNode [
	self key notNil ifTrue: [ self key parent: nil ].
	key := aNode.
	self key notNil ifTrue: [ self key parent: self ]
]

{ #category : #generated }
RubyAssociationNode >> nodeVariables [
	^ #(key value)
]

{ #category : #generated }
RubyAssociationNode >> tokenVariables [
	^ #(arrow)
]

{ #category : #generated }
RubyAssociationNode >> value [
	^ value
]

{ #category : #generated }
RubyAssociationNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
