Class {
	#name : #GtRubyRouteImporter,
	#superclass : #Object,
	#traits : 'TRubyProgramNodeVisitor',
	#classTraits : 'TRubyProgramNodeVisitor classTrait',
	#instVars : [
		'importer',
		'insideDraw',
		'namespace',
		'resourceNames',
		'paths'
	],
	#category : #'GToolkit4Ruby-Importer'
}

{ #category : #visiting }
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

{ #category : #visiting }
GtRubyRouteImporter >> addPathPart: ns [
	paths := paths
		collect: [ :each | 
			((each endsWith: '/') or: [ ns beginsWith: '/' ])
				ifTrue: [ each last = ns first
						ifTrue: [ each allButLast , ns ]
						ifFalse: [ each , ns ] ]
				ifFalse: [ each , '/' , ns ] ]
]

{ #category : #visiting }
GtRubyRouteImporter >> addRouteFrom: aNode to: method named: methodName verb: verbString [
	| route |
	route := GtRubyRoute new.
	importer model add: route.
	importer storeAST: aNode into: route.
	importer addSourceFor: aNode to: route.
	importer currentFile addEntity: route.
	route methodName: methodName.
	route method: method.
	route verb: verbString.
	route paths: paths.
	^ route
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
				ifFalse: [ (importer rubyClassNameFrom: namespace removePluralization: false)
						, '::' , className ])
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
	resourceNames := #().
	paths := Set with: '/'
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
	self addPathPart: ns.
	namespace := namespace isEmpty
		ifTrue: [ ns ]
		ifFalse: [ namespace , '::' , ns ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processNonResourceRoute: aNode [
	| callName verb |
	callName := aNode name source.
	callName = 'root'
		ifTrue: [ verb := 'GET' ]
		ifFalse: [ self addPathFrom: aNode.
			verb := callName asUppercase ].
	(self lookupNonResourceRouteNameFrom: aNode)
		ifNil: [ resourceNames isEmpty
				ifTrue: [ self
						addRouteFrom: aNode
						to: nil
						named: '?'
						verb: verb ]
				ifFalse: [ resourceNames
						do: [ :each | 
							| className |
							className := (importer
								rubyClassNameFrom: each first
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
												named: name
												verb: verb ] ] ] ] ]
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
				named: methodName
				verb: verb ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processResourceRoute: aNode [
	| actions methodNames isResources |
	resourceNames := Set new.
	actions := #(#('index' 'GET' '') #('new' 'GET' '/new') #('create' 'POST' '') #('show' 'GET' '/<1s>') #('edit' 'GET' '/<1s>/edit') #('update' 'PUT' '/<1s>') #('update' 'PATCH' '/<1s>') #('destroy' 'DELETE' '/<1s>')).
	isResources := aNode name source = 'resources'.
	isResources
		ifFalse: [ actions := actions allButFirst ].
	self
		normalArgumentsOf: aNode
		do: [ :arg | 
			| name |
			name := arg source allButFirst.
			(arg isKindOf: RubySymbolNode)
				ifTrue: [ resourceNames
						add:
							{name.
							name.
							'?'} ] ].
	self
		associativeArgumentsOf: aNode
		do: [ :arg | 
			| name |
			name := arg key source.
			name = 'controller:'
				ifTrue: [ resourceNames
						do:
							[ :each | each at: 1 put: (importer stripQuotesFrom: arg value source) ] ].
			name = 'path:'
				ifTrue: [ resourceNames
						do:
							[ :each | each at: 2 put: (importer stripQuotesFrom: arg value source) ] ].
			name = 'only:'
				ifTrue: [ methodNames := self symbolsIn: arg value.
					actions := actions
						select: [ :each | methodNames includes: each first ] ].
			name = 'except:'
				ifTrue: [ methodNames := self symbolsIn: arg value.
					actions := actions
						reject: [ :each | methodNames includes: each first ] ] ].
	resourceNames
		do: [ :resource | 
			| currentPaths |
			currentPaths := paths.
			self addPathPart: resource second.
			actions
				do: [ :action | 
					| rubyClassName actionPaths |
					actionPaths := paths.
					isResources
						ifTrue: [ self addPathPart: (action third expandMacrosWith: resource third) ].
					rubyClassName := (importer
						rubyClassNameFrom: resource first
						removePluralization: false) , 'Controller'.
					self
						addRouteFrom: aNode
						to:
							((self findMethod: action first inClass: rubyClassName)
								ifNil: [ self
										findMethod: action first
										inClass:
											(SmaCCVariableDefinition
												pluralNameFor:
													(importer rubyClassNameFrom: resource first removePluralization: false))
												, 'Controller' ])
						named: action first
						verb: action second.
					paths := actionPaths ].
			paths := currentPaths ].
	self addPathPart: resourceNames anyOne second.
	isResources
		ifTrue: [ self addPathPart: resourceNames anyOne third ]
]

{ #category : #visiting }
GtRubyRouteImporter >> processScope: aNode [
	| path |
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
						ifFalse: [ namespace , '::' , ns ] ] ].
	self
		normalArgumentsOf: aNode
		do: [ :arg | 
			(arg isKindOf: RubyStringNode)
				ifTrue: [ path := importer stripQuotesFrom: arg source ]
				ifFalse: [ path := arg source ] ].
	path notNil
		ifTrue: [ (path beginsWith: '/')
				ifTrue: [ paths := Set with: path ]
				ifFalse: [ self addPathPart: path ] ]
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
	| name originalDraw originalNamespace originalResourceNames originalPaths |
	originalDraw := insideDraw.
	originalNamespace := namespace.
	originalResourceNames := resourceNames.
	originalPaths := paths.
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
			resourceNames := originalResourceNames.
			paths := originalPaths ]
]
