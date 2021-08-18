Class {
	#name : 'GtRubyRoute',
	#superclass : 'FAMIXSourcedEntity',
	#instVars : [
		'verb',
		'method',
		'methodName',
		'path'
	],
	#category : 'GToolkit4Ruby-Model'
}

{ #category : 'accessing' }
GtRubyRoute >> gtControllerSourceFor: aView [
	<gtView>
	^ self method
		ifNil: [ aView empty ]
		ifNotNil: [ :m | 
			(m gtASTNode
				ifNil: [ m gtSourceFor: aView ]
				ifNotNil: [ :ast | ast gtSourceFor: aView ])
				title: 'Controller source' ]
]

{ #category : 'accessing' }
GtRubyRoute >> gtDisplayOn: aStream [
	verb notNil
		ifTrue: [ verb gtDisplayOn: aStream.
			aStream space ].
	path notNil
		ifTrue: [ path gtDisplayOn: aStream.
			aStream space ].
	aStream nextPutAll: '-> '.
	self method
		ifNil: [ aStream
				nextPutAll: '.';
				nextPutAll: (methodName ifNil: [ '' ]);
				nextPutAll: '()' ]
		ifNotNil: [ :m | m gtDisplayOn: aStream ]
]

{ #category : 'ui' }
GtRubyRoute >> gtExplainerFor: aView [
	<gtView>
	self hasSourceAnchors
		ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Explainer' translated;
		priority: 5;
		stencil: [ | container routes |
			routes := self mooseModel allRubyRoutes
				select: [ :each | 
					each hasSourceAnchors
						and: [ self sourceAnchor fileName = each sourceAnchor fileName
								and: [ self method sourceAnchor fileName
										= each method sourceAnchor fileName ] ] ].
			container := BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				layout: BlLinearLayout horizontal.
			container explainer isExplanationHolder: true.
			container
				addChild:
					(self
						sourceEditorFor: self sourceAnchor
						styler: (self routeStylerForRoutes: routes)).
			container
				addChild:
					(self
						sourceEditorFor: self method sourceAnchor
						styler: (self methodStylerForRoutes: routes)).
			container ]
]

{ #category : 'ui' }
GtRubyRoute >> gtSourceFor: aView [
	^ self gtASTNode notNil
		ifFalse: [ super gtSourceFor: aView ]
		ifTrue: [ self gtASTNode gtSourceFor: aView ]
]

{ #category : 'testing' }
GtRubyRoute >> hasSourceAnchors [
	^ self sourceAnchor notNil
		and: [ self method notNil and: [ self method sourceAnchor notNil ] ]
]

{ #category : 'accessing' }
GtRubyRoute >> method [
	<MSEProperty: #method type: #FAMIXMethod opposite: #routes>
	^ method
]

{ #category : 'accessing' }
GtRubyRoute >> method: aMethod [
	method := FMMultivalueLink
		on: self
		update: #routes
		from: self method
		to: aMethod
]

{ #category : 'accessing' }
GtRubyRoute >> methodName [
	^ methodName
]

{ #category : 'accessing' }
GtRubyRoute >> methodName: anObject [
	methodName := anObject
]

{ #category : 'ui' }
GtRubyRoute >> methodStylerForRoutes: aCollection [
	| locations |
	locations := (aCollection
		groupedBy: [ :each | each method sourceAnchor startPos ])
		collect:
			[ :routes | (routes collect: [ :each | each sourceAnchor startPos ]) asSet ].
	^ (GtSmaCCParserStyler forParser: RubyParser)
		stylerRules:
			{(GtSmaCCNodeStylerRule
				nodeClassName: #RubyMethodNode
				styleBlock: [ :styler :node :text | 
					| positions |
					positions := locations at: node startPosition ifAbsent: [ #() ].
					positions notEmpty
						ifTrue: [ (text from: node name startPosition to: node name stopPosition)
								glamorousExplanationFor: ('R' , node startPosition asString) asSymbol.
							positions
								do: [ :each | 
									(text
										from: node name startPosition - 1
										to: node name startPosition - 1)
										attributes:
											{((GtYellowCircleExplanationTextAdornment
												forIdentifier: ('M' , each asString) asSymbol) size: 0)} ] ] ])}
]

{ #category : 'accessing' }
GtRubyRoute >> path [
	<MSEProperty: #path type: #GtUrlPath opposite: #routes>
	^ path
]

{ #category : 'accessing' }
GtRubyRoute >> path: urlPath [
	path := FMMultivalueLink
		on: self
		update: #routes
		from: self path
		to: urlPath
]

{ #category : 'ui' }
GtRubyRoute >> routeStylerForRoutes: aCollection [
	| locations |
	locations := (aCollection
		groupedBy: [ :each | each sourceAnchor startPos ])
		collect:
			[ :routes | (routes collect: [ :each | each method sourceAnchor startPos ]) asSet ].
	^ (GtSmaCCParserStyler forParser: RubyParser)
		stylerRules:
			{(GtSmaCCNodeStylerRule
				nodeClassName: #RubyCallNode
				styleBlock: [ :styler :node :text | 
					| positions |
					positions := locations at: node startPosition ifAbsent: [ #() ].
					positions notEmpty
						ifTrue: [ (text from: node name startPosition to: node name stopPosition)
								glamorousExplanationFor: ('M' , node startPosition asString) asSymbol.
							positions
								do: [ :each | 
									(text from: node name startPosition to: node name stopPosition)
										attributes:
											{((GtYellowCircleExplanationTextAdornment
												forIdentifier: ('R' , each asString) asSymbol) size: 0)} ] ] ])}
]

{ #category : 'ui' }
GtRubyRoute >> sourceEditorFor: anchor styler: aStyler [
	| container sourceElement sourceContainer compositeStyler look source label |
	source := anchor completeText.
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		background: Color white.
	label := BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		text: anchor fileName asFileReference basename asRopedText.
	label margin: (BlInsets left: 15).
	label hMatchParent.
	container addChild: label.
	sourceContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		background: Color white;
		aptitude: BrShadowAptitude.
	look := BrGlamorousCodeEditorAptitude new.
	sourceElement := BrEditor new.
	compositeStyler := GtCompositeSmaCCASTStyler forParser: RubyParser.
	compositeStyler
		stylers:
			{RubyParser gtStyler.
			aStyler}.
	look styler: compositeStyler.
	sourceElement
		aptitude: look;
		styler: compositeStyler;
		text: source asRopedText.
	sourceElement
		scrollToPosition: (source lineNumberCorrespondingToIndex: anchor startPos).
	sourceContainer addChild: sourceElement.
	container addChild: sourceContainer.
	^ container
]

{ #category : 'accessing' }
GtRubyRoute >> verb [
	^ verb
]

{ #category : 'accessing' }
GtRubyRoute >> verb: aString [
	verb := aString
]
