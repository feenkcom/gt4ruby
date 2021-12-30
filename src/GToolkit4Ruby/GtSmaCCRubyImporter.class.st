Class {
	#name : #GtSmaCCRubyImporter,
	#superclass : #GtRubyImporter,
	#traits : 'TRubyProgramNodeVisitor - {#visitFile:}',
	#classTraits : 'TRubyProgramNodeVisitor classTrait',
	#instVars : [
		'includes'
	],
	#category : #'GToolkit4Ruby-Importer'
}

{ #category : #importing }
GtSmaCCRubyImporter >> findTableForClass: aClass [
	| tableName |
	tableName := SmaCCVariableDefinition
		pluralNameFor:
			(String
				streamContents: [ :stream | 
					aClass name
						keysAndValuesDo: [ :i :each | 
							i == 1
								ifFalse: [ each isUppercase
										ifTrue: [ stream nextPut: $_ ] ].
							stream nextPut: each asLowercase ] ]).
	^ tables
		at: tableName
		ifAbsent: [ (aClass propertyNamed: #ast)
				ifNotNil: [ :node | 
					node statements
						do: [ :each | 
							((each isKindOf: RubyAssignmentNode)
								and: [ each lhs source = 'self.table_name' ])
								ifTrue: [ ^ tables
										at: (self stripQuotesFrom: each value source)
										ifAbsent: [  ] ] ] ].
			nil ]
]

{ #category : #visiting }
GtSmaCCRubyImporter >> importASTs: aCollection [
	includes := OrderedCollection new.
	super importASTs: aCollection.
	includes do: [ :each | each first rubyIncludedContainers add: (self ensureModuleNamed: each last) ]
]

{ #category : #testing }
GtSmaCCRubyImporter >> isAssignment: aNode [
	^ aNode isKindOf: RubyAssignmentNode
]

{ #category : #importing }
GtSmaCCRubyImporter >> namespaceFrom: aNode [
	| current ns name |
	ns := ''.
	current := aNode.
	[ current notNil ]
		whileTrue: [ ((current isKindOf: RubyCallNode)
				and: [ current name source = 'namespace' ])
				ifTrue: [ name := current args first source.
					ns := name first = $:
						ifTrue: [ name allButFirst , '::' , ns ]
						ifFalse: [ (self stripQuotesFrom: name) , '::' , ns ] ].
			current := current parent ].
	^ ns
]

{ #category : #importing }
GtSmaCCRubyImporter >> outputArgs: aNode on: stream [
	aNode args
		do: [ :each | 
			| current |
			current := each.
			(current isKindOf: RubyArrayExpressionNode)
				ifTrue: [ self outputArgs: each on: stream ].
			(current isKindOf: RubyAssignmentNode)
				ifTrue: [ current := current lhs ].
			(current isKindOf: RubyVariableNode)
				ifTrue: [ stream nextPutAll: current name source ] ]
		separatedBy: [ stream nextPutAll: ', ' ]
]

{ #category : #parsing }
GtSmaCCRubyImporter >> parseFile: aFile [
	| ast fileRef |
	fileRef := aFile asFileReference.
	ast := RubyParser parseWithErrors: fileRef contents.
	ast filename: fileRef pathString.
	^ ast
]

{ #category : #importing }
GtSmaCCRubyImporter >> processRouteFiles [
	| first |
	first := true.
	[ routeFiles notEmpty ]
		whileTrue: [ currentFile := routeFiles first attributeNamed: #entity.
			GtSmaCCRubyRouteImporter new
				importer: self;
				insideDraw: first not;
				accept: routeFiles removeFirst.
			first := false ]
]

{ #category : #importing }
GtSmaCCRubyImporter >> processSchemaCall: aNode [
	| name |
	name := aNode name source.
	name = 'create_table'
		ifTrue: [ | tableName |
			tableName := self stripQuotesFrom: aNode args first source.
			currentTable := GtTable new name: tableName.
			mooseModel add: currentTable.
			self storeAST: aNode into: currentTable.
			currentFile addEntity: currentTable.
			self addSourceFor: aNode to: currentTable.
			tables at: tableName put: currentTable.
			aNode args
				do: [ :each | 
					(each isKindOf: RubyAssociationNode)
						ifTrue: [ each key source = 'id:'
								ifTrue: [ | column |
									column := GtTableColumn new name: 'id'.
									mooseModel add: column.
									self storeAST: each into: column.
									currentFile addEntity: column.
									self addSourceFor: each to: column.
									currentTable addAttribute: column ] ] ].
			self visitProgram: aNode.
			currentTable := nil.
			^ self ]
		ifFalse: [ (currentTable notNil
				and:
					[ #('binary' 'boolean' 'date' 'datetime' 'decimal' 'float' 'integer' 'primary_key' 'string' 'text' 'time' 'timestamp')
						includes: name ])
				ifTrue: [ | column |
					column := GtTableColumn new
						name: (self stripQuotesFrom: aNode args first source).
					mooseModel add: column.
					self storeAST: aNode into: column.
					currentFile addEntity: column.
					self addSourceFor: aNode to: column.
					currentTable addAttribute: column ] ].
	^ self visitProgram: aNode
]

{ #category : #visiting }
GtSmaCCRubyImporter >> visitCall: aNode [
	| name |
	name := aNode name ifNotNil: [ :token | token source ].
	(name = 'include' and: [ aNode args size = 1 ])
		ifTrue:
			[ self classOrModuleScope
				ifNotNil:
					[ :item | 
					((aNode args first isKindOf: RubyVariableNode) or: [ aNode args first isKindOf: RubyAccessExpressionNode ])
						ifTrue:
							[ includes
								add:
									{item.
										aNode args first source} ] ] ].
	insideSchemaFile ifTrue: [ ^ self processSchemaCall: aNode ].
	^ self visitExpression: aNode
]

{ #category : #visiting }
GtSmaCCRubyImporter >> visitClass: aNode [
	| class |
	class := self
		ensureClassNamed:
			(self
				fullNameFor:
					(aNode name
						ifNotNil: [ :cls | cls source ]
						ifNil: [ 'anonymous ' , aNode startPosition printString ])).
	aNode superclass
		ifNotNil: [ :spr | 
			superclasses
				add:
					{class.
					spr source} ].
	self storeAST: aNode into: class.
	currentFile addEntity: class.
	self addSourceFor: aNode to: class.
	^ self assignScope: class around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtSmaCCRubyImporter >> visitMethod: aNode [
	| method container |
	container := self containerScope.
	method := (container isKindOf: FAMIXClass)
		ifTrue: [ self ensureMethodNamed: aNode name source ]
		ifFalse: [ self ensureFunctionNamed: aNode name source ].
	self storeAST: aNode into: method.
	currentFile addEntity: method.
	(container isKindOf: FAMIXClass)
		ifTrue: [ method parentType: container ]
		ifFalse: [ method container: container ].
	method sourceAnchor: (self sourceAnchorFor: aNode).
	method
		signature:
			(String
				streamContents: [ :stream | 
					stream nextPutAll: aNode name source.
					stream nextPut: $(.
					self outputArgs: aNode on: stream.
					stream nextPut: $) ]).
	^ self
		assignScope: method
		around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtSmaCCRubyImporter >> visitModule: aNode [
	| module |
	module := self
		ensureModuleNamed: (self fullNameFor: aNode name source).
	self storeAST: aNode into: module.
	currentFile addEntity: module.
	self addSourceFor: aNode to: module.
	^ self
		assignScope: module
		around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtSmaCCRubyImporter >> visitVariable: aNode [
	| name |
	name := aNode name source.
	(name beginsWith: '@@')
		ifTrue: [ self createClassVariableReferenceFrom: aNode ]
		ifFalse: [ (name beginsWith: '@')
				ifTrue: [ self createInstanceVariableReferenceFrom: aNode ] ].
	^ self visitProgram: aNode
]
