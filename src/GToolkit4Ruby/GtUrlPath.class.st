Class {
	#name : #GtUrlPath,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
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

{ #category : #accessing }
GtUrlPath >> gtPathTreeFor: aView [
	<gtView>
	^ aView columnedTree
		priority: 0;
		title: 'Path tree';
		items: [ {self} ];
		children: #children;
		column: 'Path' text: #gtDisplayString;
		column: 'Routes' text: [ :each | 
			', ' join: (each routes 
				collect: [:route | route verb ]
				thenSelect: [:verb | verb notNil ]) ];
		expandOneLevel
]

{ #category : #accessing }
GtUrlPath >> gtRoutesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Routes';
		items: [self routes];
		column: 'Kind' text: #verb;
		column: 'Path' text: #path;
		column: 'Method' text: #method
]

{ #category : #initialization }
GtUrlPath >> initialize [
	super initialize.
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

{ #category : #printing }
GtUrlPath >> mooseNameOn: aStream [
	self isRoot
		ifFalse: [ parent mooseNameOn: aStream ].
	(self isRoot or: [ parent isRoot not ])
		ifTrue: [ aStream nextPut: $/ ].
	aStream nextPutAll: (self name ifNil: [''])
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
	<MSEProperty: #routes type: #GtRubyRoute opposite: #path>
	<multivalued>
	^ routes
]

{ #category : #accessing }
GtUrlPath >> routes: aCollection [
	routes value: aCollection
]
