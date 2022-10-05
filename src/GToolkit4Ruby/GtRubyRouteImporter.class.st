Class {
	#name : #GtRubyRouteImporter,
	#superclass : #Object,
	#instVars : [
		'importer',
		'insideDraw',
		'namespace',
		'resourceNames',
		'paths'
	],
	#category : #'GToolkit4Ruby-Importer'
}

{ #category : #importing }
GtRubyRouteImporter >> addPathFrom: aNode [
	self
		normalArgumentsOf: aNode
		do:
			[ :each | ^ self addPathPart: (importer stripQuotesFrom: each source) ].
	self
		associativeArgumentsOf: aNode
		do: [ :each | 
			each arrow notNil
				ifTrue: [ ^ self addPathPart: (importer stripQuotesFrom: each key source) ] ]
]

{ #category : #importing }
GtRubyRouteImporter >> addPathPart: ns [
	paths := paths collect: [ :each | each / ns ]
]

{ #category : #importing }
GtRubyRouteImporter >> addRouteFrom: aNode to: method named: methodName verb: verbString [
	paths
		do: [ :each | 
			| route |
			route := GtRubyRoute new.
			importer model add: route.
			importer storeAST: aNode into: route.
			importer addSourceFor: aNode to: route.
			importer currentFile addEntity: route.
			route methodName: methodName.
			route method: method.
			route verb: verbString.
			route path: each ]
]

{ #category : #importing }
GtRubyRouteImporter >> findMethod: methodName inClass: className [
	^ importer classes
		at:
			((className includes: $:)
				ifTrue: [ className ]
				ifFalse: [ (importer rubyClassNameFrom: namespace removePluralization: false)
						, '::' , className ])
		ifPresent: [ :cls | cls lookUp: methodName , '()' ]
		ifAbsent: [ importer classes
				keysAndValuesDo: [ :key :value | 
					(key = className or: [ key endsWith: '::' , className ])
						ifTrue: [ (value lookUp: methodName , '()') ifNotNil: [ :m | ^ m ] ] ].
			nil ]
]

{ #category : #accessing }
GtRubyRouteImporter >> importer [
	^ importer
]

{ #category : #accessing }
GtRubyRouteImporter >> importer: rubyImporter [
	importer := rubyImporter.
	paths := OrderedCollection with: importer rootUrl
]

{ #category : #initialization }
GtRubyRouteImporter >> initialize [
	super initialize.
	namespace := ''.
	resourceNames := #()
]

{ #category : #accessing }
GtRubyRouteImporter >> insideDraw [
	^ insideDraw
]

{ #category : #accessing }
GtRubyRouteImporter >> insideDraw: anObject [
	^ insideDraw := anObject
]

{ #category : #importing }
GtRubyRouteImporter >> lookupNonResourceRouteNameFrom: aNode [
	self
		associativeArgumentsOf: aNode
		do: [ :each | 
			| source |
			(each arrow notNil or: [ each key source = 'to:' ])
				ifTrue: [ source := importer stripQuotesFrom: each value source.
					(source includes: $#)
						ifTrue: [ ^ source ] ] ].
	^ nil
]

{ #category : #importing }
GtRubyRouteImporter >> processDraw: aNode [
	
]

{ #category : #visiting }
GtRubyRouteImporter >> visitCall: aNode [
	| name originalDraw originalNamespace originalResourceNames originalPaths |
	originalDraw := insideDraw.
	originalNamespace := namespace.
	originalResourceNames := resourceNames.
	originalPaths := paths.
	[ name := aNode name
		ifNotNil: [ :token | token source ]
		ifNil: [ '' ].
	insideDraw
		ifTrue: [ (#('get' 'post' 'patch' 'put' 'delete' 'root') includes: name)
				ifTrue: [ self processNonResourceRoute: aNode ].
			(#('resources' 'resource') includes: name)
				ifTrue: [ self processResourceRoute: aNode ].
			name = 'namespace'
				ifTrue: [ self processNamespace: aNode ].
			name = 'scope'
				ifTrue: [ self processScope: aNode ].
			name = 'draw'
				ifTrue: [ self processDraw: aNode ] ]
		ifFalse: [ insideDraw := name = 'draw' ].
	self visitProgram: aNode ]
		ensure: [ insideDraw := originalDraw.
			namespace := originalNamespace.
			resourceNames := originalResourceNames.
			paths := originalPaths ]
]
