Class {
	#name : #GtRubyExplainerStyler,
	#superclass : #GtSmaCCASTStyler,
	#traits : 'TRubyProgramNodeVisitor',
	#classTraits : 'TRubyProgramNodeVisitor classTrait',
	#instVars : [
		'explanations',
		'completionAction'
	],
	#category : 'GToolkit4Ruby-Explainer'
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
GtRubyExplainerStyler >> visitAliasStatement: aNode [
	self explain: aNode as: #Alias.
	self visitSmaCCParseNode: aNode
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
GtRubyExplainerStyler >> visitBoolean: aNode [
	self explain: aNode as: #Boolean.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitBreak: aNode [
	self explain: aNode as: #Break.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitCall: aNode [
	aNode name notNil ifTrue: [ self explain: aNode name as: #Call ].
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitCase: aNode [
	self explain: aNode as: #Case.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitCharacter: aNode [
	self explain: aNode as: #Character.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitClass: aNode [
	self explain: aNode as: #Class.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitConditionalExpression: aNode [
	self explain: aNode questionMark as: #Ternary.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitDictionary: aNode [
	self explain: aNode as: #Hash.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitEnsure: aNode [
	self explain: aNode as: #Ensure.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitFile: aNode [
	aNode comments asSet do: [ :each | self explainComment: each ].
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitFor: aNode [
	self explain: aNode as: #For.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitIf: aNode [
	self explain: aNode as: #If.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitIfModifier: aNode [
	self explain: aNode ifToken as: #'If Modifier'.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitLambda: aNode [
	self explain: aNode as: #Lambda.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitMethod: aNode [
	self explain: aNode as: #Method.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitModule: aNode [
	self explain: aNode as: #Module.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitNext: aNode [
	self explain: aNode as: #Next.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitNil: aNode [
	self explain: aNode as: #Pseudo.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitNumber: aNode [
	self explain: aNode as: #Number.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitRangeExpression: aNode [
	self explain: aNode operator as: #Range.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitRegex: aNode [
	self explain: aNode as: #Regex.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitRescue: aNode [
	self explain: aNode as: #Rescue.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitRescueModifier: aNode [
	self explain: aNode rescueToken as: #'Rescue Modifier'.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitRetry: aNode [
	self explain: aNode as: #Retry.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitReturn: aNode [
	self explain: aNode as: #Return.
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
GtRubyExplainerStyler >> visitUndefStatement: aNode [
	self explain: aNode as: #Undefine.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitUnless: aNode [
	self explain: aNode as: #Unless.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitUnlessModifier: aNode [
	self explain: aNode unlessToken as: #'Unless Modifier'.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitUntil: aNode [
	self explain: aNode as: #Until.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitUntilModifier: aNode [
	self explain: aNode untilToken as: #'Until Modifier'.
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
	(#('__FILE__' '__LINE__') includes: name)
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

{ #category : #visiting }
GtRubyExplainerStyler >> visitWhen: aNode [
	self explain: aNode as: #When.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitWhile: aNode [
	self explain: aNode as: #While.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitWhileModifier: aNode [
	self explain: aNode whileToken as: #'While Modifier'.
	self visitSmaCCParseNode: aNode
]

{ #category : #visiting }
GtRubyExplainerStyler >> visitYield: aNode [
	self explain: aNode as: #Yield.
	self visitSmaCCParseNode: aNode
]
