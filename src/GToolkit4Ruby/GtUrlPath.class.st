Class {
	#name : #GtUrlPath,
	#superclass : #FAMIXEntity,
	#instVars : [
		'name',
		'parent',
		'children',
		'routes'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #constructing }
GtUrlPath >> / aString [
	^ (aString substrings: '/')
		inject: self
		into: [ :sum :each | 
			| path |
			path := sum children
				detect: [ :child | child name = each ]
				ifNone: [ path := self class new
						name: each;
						parent: sum;
						yourself.
					self mooseModel ifNotNil: [ :m | m add: path ].
					path ].
			path ]
]

{ #category : #accessing }
GtUrlPath >> children [
	<MSEProperty: #children type: #GtUrlPath opposite: #parent>
	<multivalued>
	^ children
]

{ #category : #accessing }
GtUrlPath >> children: aCollection [
	children value: aCollection
]

{ #category : #printing }
GtUrlPath >> gtDisplayOn: aStream [
	self isRoot
		ifFalse: [ parent gtDisplayOn: aStream ].
	(self isRoot or: [ parent isRoot not ])
		ifTrue: [ aStream nextPut: $/ ].
	name gtDisplayOn: aStream
]

{ #category : #initialization }
GtUrlPath >> initialize [
	super initialize.
	name := ''.
	children := FMNullMultivalueLink
		on: self
		opposite: #parent:
		selector: #children.
	routes := FMMultiMultivalueLink on: self opposite: #paths
]

{ #category : #testing }
GtUrlPath >> isRoot [
	^ parent isNil
]

{ #category : #accessing }
GtUrlPath >> name [
	^ name
]

{ #category : #accessing }
GtUrlPath >> name: aString [
	name := aString
]

{ #category : #accessing }
GtUrlPath >> parent [
	<MSEProperty: #parent type: #GtUrlPath opposite: #children>
	^ parent
]

{ #category : #accessing }
GtUrlPath >> parent: urlPath [
	parent := FMMultivalueLink
		on: self
		update: #children
		from: self parent
		to: urlPath
]

{ #category : #accessing }
GtUrlPath >> routes [
	<MSEProperty: #routes type: #GtRubyRoute opposite: #paths>
	<multivalued>
	^ routes
]

{ #category : #accessing }
GtUrlPath >> routes: aCollection [
	routes value: aCollection
]
