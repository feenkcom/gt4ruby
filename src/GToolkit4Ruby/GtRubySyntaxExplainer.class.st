Class {
	#name : #GtRubySyntaxExplainer,
	#superclass : #BrStencil,
	#instVars : [
		'tooltips',
		'tooltipsContainer',
		'tooltipsTarget',
		'constructsContainer',
		'source'
	],
	#category : #'GToolkit4Ruby-Explainer'
}

{ #category : #'instance creation' }
GtRubySyntaxExplainer class >> onSource: aString [
	^ self new
		source: aString;
		yourself
]

{ #category : #ui }
GtRubySyntaxExplainer >> constructsList [
	| verticalContainer |
	verticalContainer := BrVerticalPane new
		fitContent;
		padding: (BlInsets all: 10).
	(tooltips groupedBy: [ :each | each first ])
		keysAndValuesDo: [ :name :items | 
			| group |
			group := self verticalGroupElement.
			items
				do:
					[ :each | group addChild: (self regularLabelFor: each second) as: each second ].
			verticalContainer
				addChild:
					(self horizontalGroupElement
						addChildren:
							{(self groupLabelWithText: name).
							self dividerBarElement.
							group}) ].
	^ verticalContainer asScrollableElement
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent ];
		background: Color white;
		aptitude: BrShadowAptitude new
]

{ #category : #ui }
GtRubySyntaxExplainer >> create [
	| mainContainer sourceEditor leftContainer rightContainer rightContainerLabel leftContainerLabel |
	mainContainer := BrHorizontalPane new
			matchParent;
			padding: (BlInsets all: 5).
	mainContainer explainer isExplanationHolder: true.
	leftContainer := BrVerticalPane new
			hFitContent;
			vMatchParent;
			padding: (BlInsets all: 5);
			margin: (BlInsets right: 20).
	rightContainer := BrVerticalPane new
			matchParent;
			padding: (BlInsets all: 5).
	tooltipsContainer := BrEditor new
			text: '' asRopedText;
			padding: (BlInsets all: 10);
			margin: (BlInsets
					top: 10
					right: 0
					bottom: 0
					left: 0);
			constraintsDo: [ :c | c horizontal matchParent ];
			visibility: BlVisibility gone;
			border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2);
			aptitude: BrShadowAptitude + BrGlamorousEditorAptitude;
			vFitContent;
			background: BrGlamorousColors textHighlightColor.
	tooltipsTarget := BrButton new
			constraintsDo: [ :c | c ignoreByLayout ];
			size: 0 @ 0;
			elevation: (BlRelativeElevation elevation: 10);
			geometry: BlCircleGeometry new.
	constructsContainer := self constructsList.
	leftContainerLabel := BrLabel new
			text: ('Ruby constructs:' asRopedText
					glamorousRegularFont;
					foreground: Color gray);
			hFitContent;
			margin: (BlInsets
					top: 0
					right: 0
					bottom: 5
					left: 0).
	rightContainerLabel := BrLabel new
			text: ('Source:' asRopedText
					glamorousRegularFont;
					foreground: Color gray);
			margin: (BlInsets
					top: 0
					right: 0
					bottom: 5
					left: 5).
	sourceEditor := self sourceEditor.
	leftContainer addChild: leftContainerLabel.
	leftContainer addChild: constructsContainer.
	rightContainer addChild: rightContainerLabel.
	rightContainer addChild: sourceEditor.
	rightContainer addChild: tooltipsContainer.
	mainContainer addChild: leftContainer.
	mainContainer addChild: rightContainer.
	^ mainContainer
]

{ #category : #ui }
GtRubySyntaxExplainer >> dividerBarElement [
	^ BlElement new
		constraintsDo: [ :c | c vertical matchParent ];
		width: 1;
		background: BrGlamorousColors lightBorderColor
]

{ #category : #ui }
GtRubySyntaxExplainer >> groupLabelWithText: aText [
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: aText;
		padding: (BlInsets all: 5);
		hExact: 70
]

{ #category : #ui }
GtRubySyntaxExplainer >> horizontalGroupElement [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c padding: (BlInsets all: 5) ];
		layout: BlLinearLayout horizontal
]

{ #category : #initialization }
GtRubySyntaxExplainer >> initialize [
	super initialize.
	tooltips := 	#(
		#('Constructs' #Alias 'Creates an alias name for a method.')
		#('Constructs' #Assignment 'An assignment node assigns values to objects.')
		#('Constructs' #Block 'A block contains multiple instructions to be executed.')
		#('Constructs' #Class 'A class defines the methods and variables that an object can use.')
		#('Constructs' #Comment  'A comment is a description for a piece of code. It has no functionalty.')
		#('Constructs' #Lambda 'Represents an anonymous function.')
		#('Constructs' #Method 'A method can be defined on any object.')
		#('Constructs' #Module 'A module can define methods that can be included in other classes.')
		#('Constructs' #Super 'Calls a method defined in a superclass.')
		#('Constructs' #Undefine 'Removes the method or variable from the class.')
		
		#('Control flow' #Break 'Exits out of an enumerable.')
		#('Control flow' #Call 'Calls another method.')
		#('Control flow' #Case 'Switch or case statement.')
		#('Control flow' #When 'A particular condition of a case statement.')
		#('Control flow' #Ensure 'Execute statements after the block finishes execution')
		#('Control flow' #For 'Execute the statements for each item in the collection.')
		#('Control flow' #If 'Classic "if" statement.')
		#('Control flow' #'If Modifier' 'Ruby allows putting the "if" condition after the expression.')
		#('Control flow' #Next 'Skips to the next item in an enumerable.')
		#('Control flow' #Rescue 'Exception handling is provided by rescue.')
		#('Control flow' #'Rescue Modifier' 'The rescue modifier provides an error handler for a specific statement without defined a block.')
		#('Control flow' #Retry 'Retries evaluating the code that triggered the exception.')
		#('Control flow' #Return 'Exits from a method.')
		#('Control flow' #Ternary 'The shortcut ternary operator if expression.')
		#('Control flow' #Unless 'Like an "if" statement, but the condition is inverted.')
		#('Control flow' #'Unless Modifier' 'Ruby allows putting the "unless" condition after the expression.')
		#('Control flow' #Until 'Repeats a statement block until the condition is true.')
		#('Control flow' #'Until Modifier' 'Ruby allows putting the "until" condition after the expression.')
		#('Control flow' #While 'Repeats a statement block while the condition is true.')
		#('Control flow' #'While Modifier' 'Ruby allows putting the "while" condition after the expression.')
		#('Control flow' #Yield 'Evaluates the block passed to the method.')
		
		#('Objects' #Array 'An array is a collection of objects.')
		#('Objects' #Boolean 'Literals that represent true or false.')
		#('Objects' #Character 'A character is a representation of a unicode value.')
		#('Objects' #Hash 'A hash maps unique keys to values.')
		#('Objects' #Number 'A literal that represents a numeric value.')
		#('Objects' #Range 'An interval of values from a start valeu to an end value.')
		#('Objects' #Regex 'A regular expression can match against strings.')
		#('Objects' #String 'A string is an array of characters.')
		#('Objects' #Symbol 'A symbol is a uniquely created string.')
		
		#('Variables' #ClassVariable 'A variable that is shared among all instances of the class.')
		#('Variables' #Constant 'A global variable that has a constant value.')
		#('Variables' #Local 'A variable that has a local scope.')
		#('Variables' #Global 'A global is a variable declared in another class that can be used anywhere else.')
		#('Variables' #InstanceVariable 'A variable that all instances of the class have.')
		#('Variables' #Pseudo 'Ruby special "variables" that cannot be assigned to.')
		#('Variables' #Self 'self represents the current object.')
	)
]

{ #category : #ui }
GtRubySyntaxExplainer >> regularLabelFor: aNodeNameSymbol [
	^ BrLabel new
		text: aNodeNameSymbol asRopedText glamorousRegularFont;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets all: 5)
]

{ #category : #accessing }
GtRubySyntaxExplainer >> source [
	^ source
]

{ #category : #accessing }
GtRubySyntaxExplainer >> source: aString [
	source := aString
]

{ #category : #ui }
GtRubySyntaxExplainer >> sourceEditor [
	| sourceElement sourceContainer compositeStyler look explainerStyler |
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
	explainerStyler := GtRubyExplainerStyler new
		completionAction: [ :symbols | self updateLabels: symbols ].
	compositeStyler
		stylers:
			{RubyParser gtStyler.
			explainerStyler}.
	look styler: compositeStyler.
	sourceElement
		aptitude: look;
		styler: compositeStyler;
		text: source asRopedText.
	sourceContainer addChild: sourceElement.
	^ sourceContainer
]

{ #category : #ui }
GtRubySyntaxExplainer >> tooltipTextFor: aSymbol [
	^ (tooltips
		detect: [ :each | each second = aSymbol ]
		ifNone: [ #('') ]) last
]

{ #category : #ui }
GtRubySyntaxExplainer >> updateLabels: aCollection [
	tooltips
		do: [ :each | 
			| type |
			type := each second.
			constructsContainer
				childNamed: each second
				ifFound: [ :label | 
					(aCollection includes: type)
						ifTrue: [ label text foreground: Color black.
							label
								aptitude:
									BrGlamorousLabelAptitude new
										+ (GtExplainerExplanationAptitude new explanationModel: type)
										+
											(BrStyleCommonAptitude new
												hovered: [ :aStyle | 
													aStyle background: BrGlamorousColors textHighlightColor.
													aStyle
														do: [ tooltipsContainer
																text: (self tooltipTextFor: type);
																visibility: BlVisibility visible ]
														after: [ tooltipsContainer
																text: '' asRopedText;
																visibility: BlVisibility gone ] ]) ]
						ifFalse: [ label text foreground: Color gray.
							label aptitude: BrGlamorousLabelAptitude ] ] ]
]

{ #category : #ui }
GtRubySyntaxExplainer >> verticalGroupElement [
	^ BrVerticalPane new fitContent
]
