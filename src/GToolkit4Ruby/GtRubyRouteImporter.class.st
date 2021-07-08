Class {
	#name : #GtRubyRouteImporter,
	#superclass : #Object,
	#traits : 'TRubyProgramNodeVisitor',
	#classTraits : 'TRubyProgramNodeVisitor classTrait',
	#instVars : [
		'importer',
		'insideDraw',
		'namespace',
		'resourceNames'
	],
	#category : #'GToolkit4Ruby-Importer'
}

{ #category : #visiting }
GtRubyRouteImporter >> addRouteFrom: aNode to: method named: methodName [
	| route |
	route := GtRubyRoute new.
	importer model add: route.
	importer storeAST: aNode into: route.
	importer addSourceFor: aNode to: route.
	importer currentFile addEntity: route.
	route methodName: methodName.
	route method: method
]

{ #category : #visiting }
GtRubyRouteImporter >> associativeArgumentsOf: aNode do: aBlock [
	aNode arguments arguments
		do: [ :arg | 
			(arg isKindOf: RubyAssociationArgumentsNode)
				ifTrue: [ arg args do: aBlock ] ]
]

{ #category : #visiting }
GtRubyRouteImporter >> findMethod: methodName inClass: className [
	^ importer classesAndModules
		at:
			((className includes: $:)
				ifTrue: [ className ]
				ifFalse: [ namespace , className ])
		ifPresent: [ :cls | cls lookUp: methodName , '()' ]
		ifAbsent: [ importer classesAndModules
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
GtRubyRouteImporter >> importer: anObject [
	importer := anObject
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

{ #category : #visiting }
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

{ #category : #visiting }
GtRubyRouteImporter >> normalArgumentsOf: aNode do: aBlock [
	aNode arguments arguments
		do: [ :arg | 
			(arg isKindOf: RubyAssociationArgumentsNode)
				ifFalse: [ aBlock value: arg ] ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processDraw: aNode [
	
]

{ #category : #visiting }
GtRubyRouteImporter >> processNamespace: aNode [
	| name ns |
	name := aNode arguments arguments first source.
	ns := name first = $:
		ifTrue: [ name allButFirst ]
		ifFalse: [ importer stripQuotesFrom: name ].
	namespace := namespace isEmpty
		ifTrue: [ ns ]
		ifFalse: [ namespace , '::' , ns ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processNonResourceRoute: aNode [
	(self lookupNonResourceRouteNameFrom: aNode)
		ifNil: [ resourceNames isEmpty
				ifTrue: [ self addRouteFrom: aNode to: nil named: '?' ]
				ifFalse: [ resourceNames
						do: [ :each | 
							| className |
							className := (importer
								rubyClassNameFrom: each
								removePluralization: false) , 'Controller'.
							self
								normalArgumentsOf: aNode
								do: [ :arg | 
									| name |
									name := arg source.
									name first = $:
										ifTrue: [ name := name allButFirst.
											self
												addRouteFrom: aNode
												to: (self findMethod: name inClass: className)
												named: name ] ] ] ] ]
		ifNotNil: [ :aString | 
			| className methodName index |
			index := aString indexOf: $#.
			className := (importer
				rubyClassNameFrom: (aString first: index - 1)
				removePluralization: false) , 'Controller'.
			methodName := aString allButFirst: index.
			self
				addRouteFrom: aNode
				to: (self findMethod: methodName inClass: className)
				named: methodName ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processResourceRoute: aNode [
	| methods |
	resourceNames := Set new.
	methods := #('index' 'new' 'create' 'show' 'edit' 'update' 'destroy')
		asSet.
	self
		normalArgumentsOf: aNode
		do: [ :arg | 
			(arg isKindOf: RubySymbolNode)
				ifTrue: [ resourceNames add: arg source allButFirst ] ].
	self
		associativeArgumentsOf: aNode
		do: [ :arg | 
			| name |
			name := arg key source.
			name = 'controller:'
				ifTrue: [ resourceNames := Set
						with: (importer stripQuotesFrom: arg value source) ].
			name = 'only:'
				ifTrue: [ methods := self symbolsIn: arg value ].
			name = 'except:'
				ifTrue: [ (self symbolsIn: arg value)
						do: [ :each | methods remove: each ifAbsent: [  ] ] ] ].
	resourceNames
		do: [ :className | 
			methods
				do: [ :methodName | 
					| route rubyClassName |
					rubyClassName := (importer
						rubyClassNameFrom: className
						removePluralization: false) , 'Controller'.
					route := GtRubyRoute new.
					importer model add: route.
					importer storeAST: aNode into: route.
					importer addSourceFor: aNode to: route.
					importer currentFile addEntity: route.
					route methodName: methodName.
					(self findMethod: methodName inClass: rubyClassName)
						ifNotNil: [ :method | route method: method ] ] ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processScope: aNode [
	self
		associativeArgumentsOf: aNode
		do: [ :arg | 
			arg key source = 'module:'
				ifTrue: [ | name ns |
					name := arg value source.
					ns := name first = $:
						ifTrue: [ name allButFirst ]
						ifFalse: [ importer stripQuotesFrom: name ].
					namespace := namespace isEmpty
						ifTrue: [ ns ]
						ifFalse: [ namespace , '::' , ns ] ] ]
]

{ #category : #visiting }
GtRubyRouteImporter >> symbolsIn: aNode [
	(aNode isKindOf: RubyArrayNode)
		ifTrue: [ ^ (aNode values ifNil: [ #() ])
				collect: [ :each | 
					| name |
					name := each source.
					name first = $:
						ifTrue: [ name allButFirst ]
						ifFalse: [ name ] ] ].
	^ #()
]

{ #category : #visiting }
GtRubyRouteImporter >> visitCall: aNode [
	| name originalDraw originalNamespace originalResourceNames |
	originalDraw := insideDraw.
	originalNamespace := namespace.
	originalResourceNames := resourceNames.
	[ name := aNode name source.
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
			resourceNames := originalResourceNames ]
]
