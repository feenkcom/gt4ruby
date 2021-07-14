Class {
	#name : #GtRubyRoute,
	#superclass : #FAMIXSourcedEntity,
	#instVars : [
		'verb',
		'method',
		'methodName',
		'path'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyRoute >> gtControllerSourceFor: aView [
	<gtView>
	^ self method
		ifNil: [ aView empty ]
		ifNotNil: [ :m | 
			(m gtASTNode
				ifNil: [ m gtSourceFor: aView ]
				ifNotNil: [ :ast | ast gtSourceFor: aView ])
				title: 'Controller source' ]
]

{ #category : #accessing }
GtRubyRoute >> gtDisplayOn: aStream [
	verb notNil
		ifTrue: [ verb gtDisplayOn: aStream.
			aStream space ].
	path notNil
		ifTrue: [ path gtDisplayOn: aStream.
			aStream space ].
	aStream nextPutAll: '-> '.
	self method
		ifNil: [ aStream
				nextPutAll: '.';
				nextPutAll: (methodName ifNil: [ '' ]);
				nextPutAll: '()' ]
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

{ #category : #accessing }
GtRubyRoute >> path [
	<MSEProperty: #path type: #GtUrlPath opposite: #routes>
	^ path
]

{ #category : #accessing }
GtRubyRoute >> path: urlPath [
	path := FMMultivalueLink
		on: self
		update: #routes
		from: self path
		to: urlPath
]

{ #category : #accessing }
GtRubyRoute >> verb [
	^ verb
]

{ #category : #accessing }
GtRubyRoute >> verb: aString [
	verb := aString
]
