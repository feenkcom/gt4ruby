Class {
	#name : #GtRubyExplainerStyler,
	#superclass : #GtSmaCCASTStyler,
	#traits : 'TRubyProgramNodeVisitor',
	#classTraits : 'TRubyProgramNodeVisitor classTrait',
	#instVars : [
		'explanations',
		'completionAction'
	],
	#category : #'GToolkit4Ruby-Explainer'
}

{ #category : #initialization }
GtRubyExplainerStyler >> completionAction: aBlock [
	completionAction := aBlock
]

{ #category : #private }
GtRubyExplainerStyler >> explain: aNode as: aSymbol [
	explanations add: aSymbol.
	(text
		from: (aNode startPosition - 1 max: 1)
		to: (aNode startPosition - 1 max: 1))
		attributes: {(GtYellowCircleExplanationTextAdornment forIdentifier: aSymbol)}
]

{ #category : #private }
GtRubyExplainerStyler >> explainComment: anInterval [
	explanations add: #Comment.
	(text from: anInterval first to: anInterval first)
		attributes: {(GtYellowCircleExplanationTextAdornment forIdentifier: #Comment)}
]

{ #category : #initialization }
GtRubyExplainerStyler >> initialize [
	super initialize.
	explanations := Set new.
	completionAction := [  ]
]

{ #category : #private }
GtRubyExplainerStyler >> styleAST: aNode [
	explanations := Set new.
	self acceptNode: aNode.
	completionAction cull: explanations
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitArrayExpression: aNode [
	(aNode left notNil and: [ aNode left source = '[' ])
		ifTrue: [ self explain: aNode as: #Array ].
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitAssignment: aNode [
	self explain: aNode operator as: #Assignment.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitBlock: aNode [
	self explain: aNode as: #Block.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitClass: aNode [
	self explain: aNode as: #Class.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitFile: aNode [
	aNode comments asSet do: [ :each | self explainComment: each ].
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitMethod: aNode [
	self explain: aNode as: #Method.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitNumber: aNode [
	self explain: aNode as: #Number.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitRegex: aNode [
	self explain: aNode as: #Regex.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitSelf: aNode [
	self explain: aNode as: #Self.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitString: aNode [
	self explain: aNode as: #String.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitSymbol: aNode [
	self explain: aNode as: #Symbol.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitVariable: aNode [
	| name |
	name := aNode name source.
	name first = $$
		ifTrue: [ self explain: aNode as: #Global ].
	name first isUppercase
		ifTrue: [ self explain: aNode as: #Constant ].
	(name first isLowercase or: [ name first = $_ ])
		ifTrue: [ self explain: aNode as: #Local ].
	(#('true' 'false' 'nil' '__FILE__' '__LINE__') includes: name)
		ifTrue: [ self explain: aNode as: #Pseudo ].
	name = 'super'
		ifTrue: [ self explain: aNode as: #Super ].
	name first = $@
		ifTrue: [ self
				explain: aNode
				as:
					((name beginsWith: '@@')
						ifTrue: [ #ClassVariable ]
						ifFalse: [ #InstanceVariable ]) ].
	self visitSmaCCParseNode: aNode
]
