Class {
	#name : #RpRubyRescueNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'type',
		'statements',
		'rescue',
		'var',
		'arrow'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyRescueNode >> acceptVisitor: aVisitor [
	^ aVisitor visitRescue: self
]

{ #category : #generated }
RpRubyRescueNode >> arrow [
	^ arrow
]

{ #category : #generated }
RpRubyRescueNode >> arrow: anObject [
	self setParent: self arrow to: nil.
	arrow := anObject.
	self setParent: self arrow to: self
]

{ #category : #generated }
RpRubyRescueNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RpRubyRescueNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RpRubyRescueNode >> nodeVariables [
	^ #(type)
]

{ #category : #generated }
RpRubyRescueNode >> otherVariables [
	^ #(arrow var)
]

{ #category : #generated }
RpRubyRescueNode >> rescue [
	^ rescue
]

{ #category : #generated }
RpRubyRescueNode >> rescue: aToken [
	rescue := aToken
]

{ #category : #generated }
RpRubyRescueNode >> statements [
	^ statements
]

{ #category : #generated }
RpRubyRescueNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RpRubyRescueNode >> tokenVariables [
	^ #(rescue)
]

{ #category : #generated }
RpRubyRescueNode >> type [
	^ type
]

{ #category : #generated }
RpRubyRescueNode >> type: aNode [
	self type notNil ifTrue: [ self type parent: nil ].
	type := aNode.
	self type notNil ifTrue: [ self type parent: self ]
]

{ #category : #generated }
RpRubyRescueNode >> var [
	^ var
]

{ #category : #generated }
RpRubyRescueNode >> var: anObject [
	self setParent: self var to: nil.
	var := anObject.
	self setParent: self var to: self
]
