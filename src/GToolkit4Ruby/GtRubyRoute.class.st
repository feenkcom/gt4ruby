Class {
	#name : #GtRubyRoute,
	#superclass : #FAMIXSourcedEntity,
	#instVars : [
		'method',
		'methodName'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyRoute >> gtDisplayOn: aStream [
	aStream nextPutAll: '-> '.
	self method
		ifNil: [ aStream
				nextPutAll: '?.';
				nextPutAll: (methodName ifNil: [ '?' ]) ]
		ifNotNil: [ :m | m gtDisplayOn: aStream ]
]

{ #category : #ui }
GtRubyRoute >> gtSourceFor: aView [
	^ self gtASTNode notNil
		ifFalse: [ super gtSourceFor: aView ]
		ifTrue: [ self gtASTNode gtSourceFor: aView ]
]

{ #category : #accessing }
GtRubyRoute >> method [
	<MSEProperty: #method type: #FAMIXMethod opposite: #routes>
	^ method
]

{ #category : #accessing }
GtRubyRoute >> method: aMethod [
	method := FMMultivalueLink
		on: self
		update: #routes
		from: self method
		to: aMethod
]

{ #category : #accessing }
GtRubyRoute >> methodName [
	^ methodName
]

{ #category : #accessing }
GtRubyRoute >> methodName: anObject [
	methodName := anObject
]
