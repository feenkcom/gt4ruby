Class {
	#name : #GtRpRubyRouteImporter,
	#superclass : #GtRubyRouteImporter,
	#traits : 'TRpRubyProgramNodeVisitor - {#visitCall:}',
	#classTraits : 'TRpRubyProgramNodeVisitor classTrait',
	#category : #'GToolkit4Ruby-Ripper-Importer'
}

{ #category : #importing }
GtRpRubyRouteImporter >> associativeArgumentsOf: aNode do: aBlock [
	aNode arguments arguments
		do: [ :arg | 
			(arg isKindOf: RpRubyAssociationArgumentsNode)
				ifTrue: [ arg args do: aBlock ] ]
]

{ #category : #importing }
GtRpRubyRouteImporter >> normalArgumentsOf: aNode do: aBlock [
	aNode arguments arguments
		do: [ :arg | 
			(arg isKindOf: RpRubyAssociationArgumentsNode)
				ifFalse: [ aBlock value: arg ] ]
]

{ #category : #importing }
GtRpRubyRouteImporter >> processNamespace: aNode [
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

{ #category : #importing }
GtRpRubyRouteImporter >> processNonResourceRoute: aNode [
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

{ #category : #importing }
GtRpRubyRouteImporter >> processResourceRoute: aNode [
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
			(arg isKindOf: RpRubySymbolNode)
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

{ #category : #importing }
GtRpRubyRouteImporter >> processScope: aNode [
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
			(arg isKindOf: RpRubyStringNode)
				ifTrue: [ path := importer stripQuotesFrom: arg source ]
				ifFalse: [ path := arg source ] ].
	path notNil
		ifTrue: [ self addPathPart: path ]
]

{ #category : #importing }
GtRpRubyRouteImporter >> symbolsIn: aNode [
	(aNode isKindOf: RpRubyArrayNode)
		ifTrue: [ ^ (aNode values ifNil: [ #() ])
				collect: [ :each | 
					| name |
					name := each source.
					name first = $:
						ifTrue: [ name allButFirst ]
						ifFalse: [ name ] ] ].
	^ #()
]
