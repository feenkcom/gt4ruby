Class {
	#name : 'GtRubySlideShow',
	#superclass : 'Object',
	#instVars : [
		'fileSystem',
		'createdActiveRecordCheck',
		'createdTableCheck'
	],
	#category : 'GToolkit4Ruby-Slides'
}

{ #category : 'active record' }
GtRubySlideShow >> activeRecordClassFileReference [
	| ref |
	ref := fileSystem / 'article.rb'.
	ref exists
		ifFalse: [ ref
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							('class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end' copyReplaceAll: String cr with: String lf) ] ].
	^ ref
]

{ #category : 'active record' }
GtRubySlideShow >> activeRecordClassStyler [
	^ (GtSmaCCParserStyler forParser: RubyParser)
		stylerRules:
			{(GtSmaCCNodeStylerRule
				nodeClassName: #RubyClassNode
				styleBlock: [ :styler :node :text | 
					(node superclass notNil
						and: [ node superclass source = 'ApplicationRecord' ])
						ifTrue: [ (text
								from: node name startPosition - 1
								to: node name startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: #activeRecordClass)}.
							(text
								from: node superclass startPosition - 1
								to: node superclass startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: #ApplicationRecord)} ] ])}
]

{ #category : 'active record' }
GtRubySlideShow >> activeRecordElement [
	| element |
	element := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 10);
		background: Color white;
		yourself.
	element
		addChild:
			(self
				sourceEditorFor: self activeRecordClassFileReference
				styler: self activeRecordClassStyler);
		addChild:
			(self
				sourceEditorFor: self schemaFileReference
				styler: self callStyler).
	^ element
]

{ #category : 'active record' }
GtRubySlideShow >> activeRecordExplanationSlideFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 2;
		newTextWithFormat: self activeRecordText;
		elementWeight: 0.6;
		element: [ self activeRecordElement ].
]

{ #category : 'active record' }
GtRubySlideShow >> activeRecordText [
	^ ('Rails uses an active record for the model. The ' asRopedText ,
		('active record class' asRopedText glamorousExplanationFor: #activeRecordClass) ,
		' should be defined as a subclass of ' asRopedText ,
		('ApplicationRecord.' asRopedText glamorousExplanationFor: #ApplicationRecord) ,
		String cr asRopedText ,
		String cr asRopedText ,
		'The ' asRopedText ,
		('active record class' asRopedText glamorousExplanationFor: #activeRecordClass) ,
		' is connected to a ' asRopedText ,
		('database table' asRopedText glamorousExplanationFor: #create_table) ,
		' and implements the standard CRUD actions. Rails uses naming conventions to map the ' asRopedText ,
		('active record class' asRopedText glamorousExplanationFor: #activeRecordClass) ,
		' to a ' asRopedText ,
		('table' asRopedText glamorousExplanationFor: #create_table) ,
		'. The class'' name is converted from camelcase to use underscores and is converted to a plural name. This can be overriden by setting the table_name property in the class.' asRopedText)
		glamorousRegularFont;
		fontSize: 16
]

{ #category : 'private' }
GtRubySlideShow >> callStyler [
	^ (GtSmaCCParserStyler forParser: RubyParser)
		stylerRules:
			{(GtSmaCCNodeStylerRule
				nodeClassName: #RubyCallNode
				styleBlock: [ :styler :node :text | 
					node name notNil
						ifTrue: [ (text
								from: node name startPosition - 1
								to: node name startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: node name source asSymbol)} ] ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RubySymbolNode
				styleBlock: [ :styler :node :text | 
					(text from: node startPosition - 1 to: node startPosition - 1)
						attributes:
							{(GtYellowCircleExplanationTextAdornment
								forIdentifier: node source asSymbol)} ])}
]

{ #category : 'routes' }
GtRubySlideShow >> controllerFileReference [
	| ref |
	ref := fileSystem / 'articles_controller.rb'.
	ref exists
		ifFalse: [ ref
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							('class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(title: "...", body: "...")

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end
end' copyReplaceAll: String cr with: String lf) ] ].
	^ ref
]

{ #category : 'routes' }
GtRubySlideShow >> controllerStyler [
	^ (GtSmaCCParserStyler forParser: RubyParser)
		stylerRules:
			{(GtSmaCCNodeStylerRule
				nodeClassName: #RubyClassNode
				styleBlock: [ :styler :node :text | 
					(node superclass notNil
						and: [ node superclass source = 'ApplicationController' ])
						ifTrue: [ (text
								from: node name startPosition - 1
								to: node name startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: node name source asSymbol)}.
							(text
								from: node superclass startPosition - 1
								to: node superclass startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: #ApplicationController)} ] ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RubyMethodNode
				styleBlock: [ :styler :node :text | 
					(#('index' 'show' 'new' 'create' 'edit' 'update' 'destroy')
						includes: node name source)
						ifTrue: [ (text from: node startPosition - 1 to: node startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: #controllerMethod)}.
							((text from: node startPosition - 1 to: node startPosition - 1)
								attributes:
									{(GtYellowCircleExplanationTextAdornment
										forIdentifier: node name source asSymbol)}) size: 0 ] ])}
]

{ #category : 'create active record' }
GtRubySlideShow >> createActiveRecordClassFileReference [
	| ref dir |
	dir := fileSystem / 'create'.
	dir ensureCreateDirectory.
	ref := dir / 'person.rb'.
	ref exists ifFalse: [ ref writeStreamDo: [ :stream |  ] ].
	^ ref
]

{ #category : 'create active record' }
GtRubySlideShow >> createActiveRecordClassStyler [
	| definedClass |
	definedClass := false.
	^ (GtNotifyingStyler forParser: RubyParser)
		stylerRules:
				{GtSmaCCNodeStylerRule
							nodeClassName: #RubyClassNode
							styleBlock:
								[ :styler :node :text | 
								| isPerson |
								isPerson := node name source = 'Person'.
								isPerson
									ifTrue:
										[ (text from: node name startPosition - 1 to: node name startPosition - 1)
											attributes: {GtYellowCircleExplanationTextAdornment forIdentifier: #personClass} ].
								(node superclass notNil and: [ node superclass source = 'ApplicationRecord' ])
									ifTrue:
										[ (text from: node superclass startPosition - 1 to: node superclass startPosition - 1)
											attributes: {GtYellowCircleExplanationTextAdornment forIdentifier: #ApplicationRecord}.
										definedClass := isPerson ] ]};
		notify:
				[ createdActiveRecordCheck checked: definedClass.
					definedClass := false ];
		yourself
]

{ #category : 'create active record' }
GtRubySlideShow >> createActiveRecordElement [
	| element |
	element := (BlElement new)
		constraintsDo:
				[ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 10);
		background: Color white;
		yourself.
	element
		addChild: (self sourceEditorFor: self createActiveRecordClassFileReference styler: self createActiveRecordClassStyler);
		addChild: (self sourceEditorFor: self createSchemaFileReference styler: self createTableStyler).
	^ element
]

{ #category : 'create active record' }
GtRubySlideShow >> createActiveRecordSlideFor: aSlide [
	<gtSlide>
	
	^ (aSlide textAndElement)
		priority: 3;
		newTextWithFormat: self createActiveRecordText;
		elementWeight: 0.6;
		element: [ self createActiveRecordElement ]
]

{ #category : 'create active record' }
GtRubySlideShow >> createActiveRecordText [
	^ ('To create an active record for a person do this:' asRopedText , String cr asRopedText
		,
			(' ' asRopedText
				attributes:
					{BrTextAdornmentDynamicAttribute new
							stencil:
								[ (createdActiveRecordCheck := BrCheckbox new)
									disable;
									aptitude: BrGlamorousCheckboxAptitude ]}) , ' Define a ' asRopedText
		, ('person class' asRopedText glamorousExplanationFor: #personClass) , ' as a subclass of ' asRopedText
		, ('ApplicationRecord' asRopedText glamorousExplanationFor: #ApplicationRecord) , '.' asRopedText , String cr asRopedText
		,
			(' ' asRopedText
				attributes:
					{BrTextAdornmentDynamicAttribute new
							stencil:
								[ (createdTableCheck := BrCheckbox new)
									disable;
									aptitude: BrGlamorousCheckboxAptitude ]}) , ' Define a ' asRopedText
		, ('persons' asRopedText glamorousExplanationFor: #personsTable) , ' table.' asRopedText)
		glamorousRegularFont;
		fontSize: 16
]

{ #category : 'create active record' }
GtRubySlideShow >> createSchemaFileReference [
	| ref dir |
	dir := fileSystem / 'create'.
	dir ensureCreateDirectory.
	ref := dir / 'schema.rb'.
	ref exists
		ifFalse:
			[ ref
				writeStreamDo:
					[ :stream | 
					stream
						nextPutAll:
							('ActiveRecord::Schema.define do

end' copyReplaceAll: String cr with: String lf) ] ].
	^ ref
]

{ #category : 'create active record' }
GtRubySlideShow >> createTableStyler [
	| personTableCreated |
	personTableCreated := false.
	^ (GtNotifyingStyler forParser: RubyParser)
		stylerRules:
				{GtSmaCCNodeStylerRule
							nodeClassName: #RubyCallNode
							styleBlock:
								[ :styler :node :text | 
								(node name notNil
									and: [ node name source = 'create_table' and: [ node args notEmpty and: [ node args first source = ':persons' ] ] ])
									ifTrue:
										[ (text from: node args first startPosition - 1 to: node args first startPosition - 1)
											attributes: {GtYellowCircleExplanationTextAdornment forIdentifier: #personsTable}.
										personTableCreated := node blocks notEmpty
											and: [ node blocks first args size = 1 and: [ node blocks first statements notEmpty ] ] ] ]};
		notify:
				[ createdTableCheck checked: personTableCreated.
					personTableCreated := false ];
		yourself
]

{ #category : 'initialize-release' }
GtRubySlideShow >> initialize [
	super initialize.
	fileSystem := FileSystem memory workingDirectory
]

{ #category : 'routes' }
GtRubySlideShow >> routesElement [
	| element |
	element := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 10);
		background: Color white;
		yourself.
	element
		addChild:
			(self
				sourceEditorFor: self routesFileReference
				styler: self callStyler);
		addChild:
			(self
				sourceEditorFor: self controllerFileReference
				styler: self controllerStyler).
	^ element
]

{ #category : 'routes' }
GtRubySlideShow >> routesExplanationSlideFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 3;
		newTextWithFormat: self routesText;
		elementWeight: 0.6;
		element: [ self routesElement ]
]

{ #category : 'routes' }
GtRubySlideShow >> routesFileReference [
	| ref |
	ref := fileSystem / 'routes.rb'.
	ref exists
		ifFalse: [ ref
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							('Rails.application.routes.draw do
  root "articles#index"

  resources :articles
end' copyReplaceAll: String cr with: String lf) ] ].
	^ ref
]

{ #category : 'routes' }
GtRubySlideShow >> routesText [
	^ ('Rails uses a routes file to specify routes from requests to ' asRopedText ,
		('controller methods' asRopedText glamorousExplanationFor: #controllerMethod) ,
		' that are run. The routes are specified inside the ' asRopedText ,
		('draw' asRopedText glamorousExplanationFor: #draw) ,
		' call''s block. One such route is the ' asRopedText ,
		('resources' asRopedText glamorousExplanationFor: #resources) ,
		' route that sets up routes for several different requests to the ' asRopedText ,
		('controller methods' asRopedText glamorousExplanationFor: #controllerMethod) ,
		'. By convention the name of the ' asRopedText ,
		('controller class' asRopedText glamorousExplanationFor: #ArticlesController) ,
		' is the name of the ' asRopedText ,
		('symbol' asRopedText glamorousExplanationFor: #':articles') ,
		' passed to the ' asRopedText ,
		('resources' asRopedText glamorousExplanationFor: #resources) ,
		' call converted to a class name with the suffix of Controller. The default ' asRopedText ,
		('resources' asRopedText glamorousExplanationFor: #resources) ,
		' call route sets up calls to the ' asRopedText ,
		('index' asRopedText glamorousExplanationFor: #index) ,
		', ' asRopedText ,
		('show' asRopedText glamorousExplanationFor: #show) ,
		', ' asRopedText ,
		('new' asRopedText glamorousExplanationFor: #new) ,
		', ' asRopedText ,
		('create' asRopedText glamorousExplanationFor: #create) ,
		', ' asRopedText ,
		('edit' asRopedText glamorousExplanationFor: #edit) ,
		', ' asRopedText ,
		('update' asRopedText glamorousExplanationFor: #update) ,
		', and ' asRopedText ,
		('destroy' asRopedText glamorousExplanationFor: #destroy) ,
		' methods in the ' asRopedText ,
		('controller' asRopedText glamorousExplanationFor: #ArticlesController) ,
		'.' asRopedText
		)
		glamorousRegularFont;
		fontSize: 16
]

{ #category : 'active record' }
GtRubySlideShow >> schemaFileReference [
	| ref |
	ref := fileSystem / 'schema.rb'.
	ref exists
		ifFalse: [ ref
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							('ActiveRecord::Schema.define do
  create_table :articles do |t|
    t.string :title
    t.text :body

    t.timestamps
  end
end' copyReplaceAll: String cr with: String lf) ] ].
	^ ref
]

{ #category : 'private' }
GtRubySlideShow >> sourceEditorFor: aFileReference styler: explainationStyler [
	| container sourceElement sourceContainer styler look label |
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		background: Color white.
	label := BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		text: (aFileReference basename asRopedText foreground: Color gray).
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
	explainationStyler isNil
		ifTrue: [ styler := RubyParser gtStyler ]
		ifFalse: [ styler := GtCompositeSmaCCASTStyler forParser: RubyParser.
			styler
				stylers:
					{RubyParser gtStyler.
					explainationStyler} ].
	look styler: styler.
	sourceElement
		aptitude: look;
		styler: styler;
		text: aFileReference contents asRopedText.
	sourceContainer addChild: sourceElement.
	container addChild: sourceContainer.
	^ container
]
