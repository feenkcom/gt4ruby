Class {
	#name : #RpRubyAssociationNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'key',
		'value',
		'arrow'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyAssociationNode >> acceptVisitor: aVisitor [
	^ aVisitor visitAssociation: self
]

{ #category : #generated }
RpRubyAssociationNode >> arrow [
	^ arrow
]

{ #category : #generated }
RpRubyAssociationNode >> arrow: aToken [
	arrow := aToken
]

{ #category : #generated }
RpRubyAssociationNode >> key [
	^ key
]

{ #category : #generated }
RpRubyAssociationNode >> key: aNode [
	self key notNil ifTrue: [ self key parent: nil ].
	key := aNode.
	self key notNil ifTrue: [ self key parent: self ]
]

{ #category : #generated }
RpRubyAssociationNode >> nodeVariables [
	^ #(key value)
]

{ #category : #generated }
RpRubyAssociationNode >> tokenVariables [
	^ #(arrow)
]

{ #category : #generated }
RpRubyAssociationNode >> value [
	^ value
]

{ #category : #generated }
RpRubyAssociationNode >> value: aNode [
	self value notNil ifTrue: [ self value parent: nil ].
	value := aNode.
	self value notNil ifTrue: [ self value parent: self ]
]
