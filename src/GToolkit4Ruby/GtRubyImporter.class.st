Class {
	#name : #GtRubyImporter,
	#superclass : #Object,
	#traits : 'TMysqlProgramNodeVisitor - {#visitProgram:}',
	#classTraits : 'TMysqlProgramNodeVisitor classTrait',
	#instVars : [
		'mooseModel',
		'scopeStack',
		'currentFile',
		'files',
		'folders',
		'classesAndModules',
		'superclasses',
		'tables',
		'insideSchemaFile',
		'currentTable',
		'routeFiles',
		'rootUrl'
	],
	#category : 'GToolkit4Ruby-Importer'
}

{ #category : #importing }
GtRubyImporter >> addReferenceTo: attribute from: aNode [
	| access |
	access := FAMIXAccess new
		from: self methodScope;
		to: attribute;
		isWrite:
			((self isAssignment: aNode parent) and: [ aNode parent lhs == aNode ]);
		sourceAnchor: (self sourceAnchorFor: aNode).
	mooseModel add: access.
	self storeAST: aNode into: access.
	currentFile addEntity: access
]

{ #category : #importing }
GtRubyImporter >> addSourceFor: aNode to: anEntity [
	| anchor |
	anchor := self sourceAnchorFor: aNode.
	anEntity sourceAnchor isNil
		ifTrue: [ ^ anEntity sourceAnchor: anchor ].
	(anEntity sourceAnchor isKindOf: FAMIXMultipleFileAnchor)
		ifFalse: [ anEntity
				sourceAnchor:
					(FAMIXMultipleFileAnchor new
						mooseModel: mooseModel;
						addSourceAnchor: anEntity sourceAnchor;
						yourself) ].
	anEntity sourceAnchor addSourceAnchor: (self sourceAnchorFor: aNode)
]

{ #category : #importing }
GtRubyImporter >> assignScope: modelObject around: aBlock [
	scopeStack addLast: modelObject.
	^ aBlock
		ensure: [ scopeStack removeLast ]
]

{ #category : #importing }
GtRubyImporter >> assignSuperclass: superclassName to: rubyClass [
	| inheritance superclass |
	classesAndModules
		at: superclassName
		ifPresent: [ :each | 
			superclass := each.
			(each isKindOf: GtRubyModule)
				ifTrue: [ superclass := self ensureClassNamed: superclassName , ' '.
					superclass name: superclass name trim.
					superclass isStub: true ] ]
		ifAbsent: [ superclass := self ensureClassNamed: superclassName.
			superclass isStub: true ].
	inheritance := FAMIXInheritance new
		subclass: rubyClass;
		superclass: superclass.
	mooseModel add: inheritance.
	rubyClass addSuperInheritance: inheritance
]

{ #category : #accessing }
GtRubyImporter >> baseDirectory [
	^ mooseModel rootFolder
]

{ #category : #accessing }
GtRubyImporter >> baseDirectory: aFileReference [
	mooseModel rootFolder: aFileReference asFileReference
]

{ #category : #importing }
GtRubyImporter >> classScope [
	scopeStack size to: 1 by: -1 do: [ :i | 
		((scopeStack at: i) isKindOf: GtRubyClass)
			ifTrue: [ ^ scopeStack at: i ] ].
	^ nil
]

{ #category : #accessing }
GtRubyImporter >> classesAndModules [
	^ classesAndModules
]

{ #category : #importing }
GtRubyImporter >> containerScope [
	scopeStack size to: 1 by: -1 do: [ :i | 
		((scopeStack at: i) isKindOf: FAMIXContainerEntity)
			ifTrue: [ ^ scopeStack at: i ] ].
	^ nil
]

{ #category : #importing }
GtRubyImporter >> createActiveRecordLinkBetweenClass: anActiveRecordClass andTable: table [
	table rubyActiveRecordClass: anActiveRecordClass.
	anActiveRecordClass activeRecordTable: table.
	^ table attributes
		do: [ :column | 
			| attribute |
			attribute := GtRubyActiveRecordAttribute new.
			attribute name: (column name removeSuffix: '_id').
			attribute tableColumn: column.
			column rubyActiveRecordAttribute: attribute.
			mooseModel add: attribute.
			anActiveRecordClass addAttribute: attribute ]
]

{ #category : #importing }
GtRubyImporter >> createActiveRecordLinksAndAttributes [
	mooseModel allClasses asOrderedCollection
		detect: [ :each | each isRubyClass and: [ each isActiveRecordBase ] ]
		ifFound: [ :theActiveRecordBase | 
			theActiveRecordBase
				allSubclassesDo: [ :anActiveRecordClass | 
					(self findTableForClass: anActiveRecordClass)
						ifNotNil: [ :table | 
							self
								createActiveRecordLinkBetweenClass: anActiveRecordClass
								andTable: table ] ] ]
]

{ #category : #importing }
GtRubyImporter >> createClassVariable: aString in: aClass [
	| attribute |
	attribute := FAMIXAttribute new.
	attribute name: aString.
	attribute beSharedVariable.
	aClass addAttribute: attribute.
	mooseModel add: attribute.
	^ attribute
]

{ #category : #importing }
GtRubyImporter >> createClassVariableReferenceFrom: aNode [
	| class name attribute |
	class := self classScope.
	class isNil
		ifTrue: [ ^ self ].
	name := aNode name source.
	attribute := class attributes
		detect: [ :each | each name = name ]
		ifNone: [ self createClassVariable: name in: class ].
	self addReferenceTo: attribute from: aNode
]

{ #category : #importing }
GtRubyImporter >> createControllerStubMethods [
	(self ensureClassNamed: 'ActionController::Base')
		ifNotNil: [ :sprClass | 
			#('index' 'new' 'create' 'show' 'edit' 'update' 'destroy')
				do: [ :name | 
					| method |
					method := self ensureMethodNamed: name.
					method parentType: sprClass.
					method isStub: true.
					method signature: name , '()' ] ]
]

{ #category : #importing }
GtRubyImporter >> createForeignKeys [
	tables
		do: [ :each | 
			each attributes
				do: [ :col | 
					(col name endsWith: '_id')
						ifTrue: [ | tableName |
							tableName := SmaCCVariableDefinition
								pluralNameFor: (col name allButLast: 3).
							tables
								at: tableName
								ifPresent: [ :table | col foreignKey: table ] ] ] ]
]

{ #category : #importing }
GtRubyImporter >> createInstanceVariable: aString in: aClass [
	| attribute |
	attribute := FAMIXAttribute new.
	attribute name: aString.
	aClass addAttribute: attribute.
	mooseModel add: attribute.
	^ attribute
]

{ #category : #importing }
GtRubyImporter >> createInstanceVariableReferenceFrom: aNode [
	| class name attribute |
	class := self classScope.
	class isNil
		ifTrue: [ ^ self ].
	name := aNode name source.
	attribute := class attributes
		detect: [ :each | each name = name ]
		ifNone: [ self createInstanceVariable: name in: class ].
	self addReferenceTo: attribute from: aNode
]

{ #category : #importing }
GtRubyImporter >> createRootUrl [
	rootUrl := GtUrlPath new.
	mooseModel add: rootUrl
]

{ #category : #importing }
GtRubyImporter >> createRoutes [
	self createControllerStubMethods.
	self createRootUrl.
	self processRouteFiles
]

{ #category : #importing }
GtRubyImporter >> createStubClassesFromTables [
	tables
		do: [ :each | 
			each rubyActiveRecordClass isNil
				ifTrue: [ | rubyClassName class inheritance |
					rubyClassName := self
						rubyClassNameFrom: each name
						removePluralization: true.
					class := self ensureClassNamed: rubyClassName.
					inheritance := FAMIXInheritance new
						superclass: self ensureActiveRecordBaseClass;
						subclass: class.
					class isStub: true.
					mooseModel add: inheritance.
					each rubyActiveRecordClass: class.
					self createActiveRecordLinkBetweenClass: class andTable: each ] ]
]

{ #category : #accessing }
GtRubyImporter >> currentFile [
	^ currentFile
]

{ #category : #importing }
GtRubyImporter >> ensureActiveRecordBaseClass [
	^ mooseModel allClasses 
		detect: [ :each | each isActiveRecordBase ]
]

{ #category : #importing }
GtRubyImporter >> ensureClassNamed: aString [
	^ classesAndModules
		at: aString
		ifAbsentPut: [ | index name namespace module class |
			index := aString lastIndexOf: $:.
			name := index > 0
				ifTrue: [ aString allButFirst: index ]
				ifFalse: [ aString ].
			class := GtRubyClass new name: name.
			index > 2
				ifTrue: [ namespace := aString first: index - 2.
					module := self ensureModuleNamed: namespace.
					class rubyContainer: module ].
			mooseModel add: class ]
]

{ #category : #importing }
GtRubyImporter >> ensureFileNamed: aFileReference [
	| filename |
	filename := aFileReference pathString.
	DiskStore activeClass isCaseSensitive
		ifFalse: [ filename := filename asUppercase ].
	^ files
		at: filename
		ifAbsentPut: [ | file |
			file := FAMIXFile new.
			file name: aFileReference basename.
			aFileReference exists
				ifTrue: [ | encoding anchor |
					encoding := [ aFileReference
						binaryReadStreamDo: [ :in | (ZnCharacterEncoder detectEncoding: in upToEnd) identifier ] ]
						on: Error
						do: [ :ex | ex return: 'utf-8' ].
					anchor := FAMIXIndexedFileEntityAnchor
						file: file
						startPos: 1
						endPos:
							(aFileReference
								readStreamEncoded: encoding
								do: [ :stream | stream contents size ])
						model: mooseModel.
					file sourceAnchor: anchor ]
				ifFalse: [ file isStub: true ].
			(self ensureFolderNamed: aFileReference parent)
				ifNotNil: [ :folder | folder addChildFileSystemEntity: file ].
			mooseModel add: file.
			file ]
]

{ #category : #importing }
GtRubyImporter >> ensureFolderNamed: aFileReference [
	^ folders
		at: aFileReference pathString
		ifAbsentPut: [ | folder |
			folder := FAMIXFolder new.
			aFileReference = mooseModel rootFolder
				ifTrue: [ folder name: '.' ]
				ifFalse: [ folder name: aFileReference basename.
					(self ensureFolderNamed: aFileReference parent)
						ifNotNil: [ :outer | outer addChildFileSystemEntity: folder ] ].
			mooseModel add: folder.
			folder ]
]

{ #category : #importing }
GtRubyImporter >> ensureFunctionNamed: aString [
	^ mooseModel add: (FAMIXFunction new name: aString)
]

{ #category : #importing }
GtRubyImporter >> ensureMethodNamed: aString [
	^ mooseModel add: (FAMIXMethod new name: aString)
]

{ #category : #importing }
GtRubyImporter >> ensureModuleNamed: aString [
	^ classesAndModules
		at: aString
		ifAbsentPut: [ | index name namespace parentModule module |
			index := aString lastIndexOf: $:.
			name := index > 0
				ifTrue: [ aString allButFirst: index ]
				ifFalse: [ aString ].
			module := GtRubyModule new name: name.
			index > 2
				ifTrue: [ namespace := aString first: index - 2.
					parentModule := self ensureModuleNamed: namespace.
					module rubyContainer: parentModule ].
			mooseModel add: module ]
]

{ #category : #importing }
GtRubyImporter >> findTableForClass: aClass [
	^ self subclassResponsibility
]

{ #category : #importing }
GtRubyImporter >> fullNameFor: aString [
	| name |
	name := aString first = $:
		ifTrue: [ aString allButFirst: 2 ]
		ifFalse: [ aString ].
	(name includes: $:)
		ifTrue: [ ^ name ].
	^ (self containerScope
		ifNotNil: [ :each | each mooseName , '::' ]
		ifNil: [ '' ]) , name
]

{ #category : #importing }
GtRubyImporter >> getParametersFor: anObject [
	| current |
	current := anObject.
	[ current isKindOf: Collection ]
		whileTrue: [ current := current anyOne ].
	^ current
]

{ #category : #importing }
GtRubyImporter >> importAST: aNode [
	self accept: aNode
]

{ #category : #importing }
GtRubyImporter >> importASTs: aCollection [
	superclasses := OrderedCollection new.
	aCollection do: [ :each | self importAST: each ].
	superclasses asSet
		do: [ :each | self assignSuperclass: each last to: each first ]
]

{ #category : #importing }
GtRubyImporter >> importTables: aMysqlFileNode [
	scopeStack := OrderedCollection new.
	self accept: aMysqlFileNode.
	self createForeignKeys
]

{ #category : #importing }
GtRubyImporter >> inferDeclaredTypes [
	tables do: [:aTable | 
		aTable attributes do: [ :aColumn |
			(aColumn foreignKey notNil and: [ aColumn rubyActiveRecordAttribute notNil ])
				ifTrue: [ 
					aColumn rubyActiveRecordAttribute declaredType: aColumn foreignKey rubyActiveRecordClass ] ]]
]

{ #category : #initialization }
GtRubyImporter >> initialize [
	super initialize.
	mooseModel := MooseModel new.
	mooseModel sourceLanguage: self sourceLanguage.
	scopeStack := OrderedCollection new.
	folders := Dictionary new.
	files := Dictionary new.
	classesAndModules := Dictionary new.
	tables := Dictionary new.
	insideSchemaFile := false.
	routeFiles := OrderedCollection new
]

{ #category : #testing }
GtRubyImporter >> isAssignment: aNode [
	^ self subclassResponsibility
]

{ #category : #importing }
GtRubyImporter >> methodScope [
	scopeStack size to: 1 by: -1 do: [ :i | 
		((scopeStack at: i) isKindOf: FAMIXMethod)
			ifTrue: [ ^ scopeStack at: i ] ].
	^ nil
]

{ #category : #accessing }
GtRubyImporter >> model [
	^ mooseModel
]

{ #category : #accessing }
GtRubyImporter >> model: aModel [
	mooseModel := aModel
]

{ #category : #parsing }
GtRubyImporter >> parseDirectory: aString [
	self baseDirectory: aString asFileReference.
	^ (RubyParser sourceFilesIn: aString)
		collect: [ :each | self parseFile: each ]
]

{ #category : #parsing }
GtRubyImporter >> parseFile: aFilename [
	^ self subclassResponsibility
]

{ #category : #importing }
GtRubyImporter >> processSchemaCall: aNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtRubyImporter >> rootUrl [
	^ rootUrl
]

{ #category : #importing }
GtRubyImporter >> rubyClassNameFrom: aString removePluralization: aBoolean [
	| name |
	name := String
		streamContents: [ :stream | 
			| capitalize |
			capitalize := true.
			aString
				do: [ :char | 
					char = $_
						ifTrue: [ capitalize := true ]
						ifFalse: [ char = $/
								ifTrue: [ stream nextPutAll: '::'.
									capitalize := true ]
								ifFalse: [ stream
										nextPut:
											(capitalize
												ifTrue: [ char asUppercase ]
												ifFalse: [ char ]).
									capitalize := false ] ] ] ].
	aBoolean
		ifTrue: [ (name endsWith: 'ies')
				ifTrue: [ name := (name allButLast: 3) , 'y' ].
			(name endsWith: 's')
				ifTrue: [ name := name allButLast ] ].
	^ name
]

{ #category : #importing }
GtRubyImporter >> sourceAnchorFor: aNode [
	^ FAMIXIndexedFileEntityAnchor
		file: currentFile
		startPos: aNode startPosition
		endPos: aNode stopPosition
		model: mooseModel
]

{ #category : #initialization }
GtRubyImporter >> sourceLanguage [
	^ FAMIXRubySourceLanguage new
]

{ #category : #importing }
GtRubyImporter >> storeAST: aNode into: anEntity [
	anEntity propertyNamed: #ast put: aNode
]

{ #category : #importing }
GtRubyImporter >> stripQuotesFrom: aString [
	((aString beginsWith: '''') or: [ aString beginsWith: '"' ])
		ifTrue: [ ^ aString copyFrom: 2 to: aString size - 1 ].
	(aString beginsWith: ':')
		ifTrue: [ ^ aString allButFirst ].
	^ aString
]

{ #category : #visiting }
GtRubyImporter >> visitColumnDefinition: aNode [
	| column |
	column := GtTableColumn new
		name: (self stripQuotesFrom: aNode columnName source).
	mooseModel add: column.
	self storeAST: aNode into: column.
	currentFile addEntity: column.
	self addSourceFor: aNode to: column.
	scopeStack last addAttribute: column.
	^ self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyImporter >> visitCreateTable: aNode [
	| table name |
	name := self stripQuotesFrom: aNode tableName source.
	table := GtTable new name: name.
	mooseModel add: table.
	self storeAST: aNode into: table.
	currentFile addEntity: table.
	self addSourceFor: aNode to: table.
	tables at: name put: table.
	^ self assignScope: table around: [ self visitSmaCCParseNode: aNode ]
]

{ #category : #visiting }
GtRubyImporter >> visitFile: aNode [
	scopeStack := OrderedCollection new.
	currentFile := self ensureFileNamed: aNode filename asFileReference.
	aNode attributeNamed: #entity put: currentFile.
	self storeAST: aNode into: currentFile.
	insideSchemaFile := aNode filename endsWith: '/db/schema.rb'.
	(aNode filename endsWith: '/config/routes.rb')
		ifTrue: [ routeFiles add: aNode ].
	^ self visitSmaCCParseNode: aNode
]
