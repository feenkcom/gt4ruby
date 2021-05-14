Class {
	#name : #RubyRescueNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'type',
		'statements',
		'rescue',
		'var',
		'arrow'
	],
	#category : #GToolkit4Ruby
}

{ #category : #generated }
RubyRescueNode >> arrow [
	^ arrow
]

{ #category : #generated }
RubyRescueNode >> arrow: anObject [
	self setParent: self arrow to: nil.
	arrow := anObject.
	self setParent: self arrow to: self
]

{ #category : #generated }
RubyRescueNode >> compositeNodeVariables [
	^ #(statements)
]

{ #category : #generated }
RubyRescueNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2
]

{ #category : #generated }
RubyRescueNode >> nodeVariables [
	^ #(type)
]

{ #category : #generated }
RubyRescueNode >> otherVariables [
	^ #(arrow var)
]

{ #category : #generated }
RubyRescueNode >> rescue [
	^ rescue
]

{ #category : #generated }
RubyRescueNode >> rescue: aToken [
	rescue := aToken
]

{ #category : #generated }
RubyRescueNode >> statements [
	^ statements
]

{ #category : #generated }
RubyRescueNode >> statements: anOrderedCollection [
	self setParent: self statements to: nil.
	statements := anOrderedCollection.
	self setParent: self statements to: self
]

{ #category : #generated }
RubyRescueNode >> tokenVariables [
	^ #(rescue)
]

{ #category : #generated }
RubyRescueNode >> type [
	^ type
]

{ #category : #generated }
RubyRescueNode >> type: aNode [
	self type notNil ifTrue: [ self type parent: nil ].
	type := aNode.
	self type notNil ifTrue: [ self type parent: self ]
]

{ #category : #generated }
RubyRescueNode >> var [
	^ var
]

{ #category : #generated }
RubyRescueNode >> var: anObject [
	self setParent: self var to: nil.
	var := anObject.
	self setParent: self var to: self
]
