Class {
	#name : #GtRubyClass,
	#superclass : #FAMIXClass,
	#instVars : [
		'activeRecordTable'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyClass >> activeRecordTable [
	<MSEProperty: #activeRecordTable type: #GtTable>
	^ activeRecordTable
]

{ #category : #accessing }
GtRubyClass >> activeRecordTable: aTable [
	activeRecordTable := aTable
]

{ #category : #accessing }
GtRubyClass >> gtAllConnectionsToDeclaredTypesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'All connections';
		painting: [ :m | 
			m nodes
				stencil: [ :c | 
					BlTextElement new
						zIndex: 10;
						text: (c name asRopedText glamorousRegularFont foreground: (self = c
										ifTrue: [ Color blue ]
										ifFalse: [ Color black alpha: 0.5 ]) ) ];
				with:
					({self} withDeepCollect: [:class | 
						class attributes
								select: [ :each | each declaredType notNil ]
								thenCollect: [ :each | each declaredType ]]).
			m edges
				fromRightCenter;
				toLeftCenter;
				connect: self attributes
				from: [ :x | self ]
				to: [ :a | a declaredType ].
			m layout horizontalTree levelDistance: 50; nodeDistance: 10 ]
]

{ #category : #accessing }
GtRubyClass >> gtDirectConnectionsToDeclaredTypesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Direct connections';
		painting: [ :m | 
			m nodes
				stencil: [ :c | 
					BlTextElement new
						zIndex: 10;
						text: (c name asRopedText glamorousRegularFont foreground: (self = c
										ifTrue: [ Color blue ]
										ifFalse: [ Color black alpha: 0.5 ]) ) ];
				with:
					{self}
						,
							(self attributes
								select: [ :each | each declaredType notNil ]
								thenCollect: [ :each | each declaredType ]).
			m edges
				fromRightCenter;
				toLeftCenter;
				connect: self attributes
				from: [ :x | self ]
				to: [ :a | a declaredType ].
			m layout horizontalTree levelDistance: 50; nodeDistance: 10 ]
]

{ #category : #accessing }
GtRubyClass >> gtHierarchyFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Hierarchy';
		painting: [ :mondrian | 
			mondrian nodes
				stencil: [ :c | 
					BlElement new
						zIndex: 10;
						border: (BlBorder paint: (self =c ifTrue: [ Color blue ] ifFalse: [Color black alpha: 0.5]) width: 2);
						width: (c numberOfAttributes max: 5);
						height: (c numberOfMethods max: 5) ];
				with: (self withSubclassHierarchy, self superclassHierarchy).
			mondrian edges
				fromCenterBottom;
				toCenterTop;
				connectFrom: #superclass.
			mondrian layout custom: GtGraphTreeLayout new ]
]

{ #category : #accessing }
GtRubyClass >> isActiveRecordBase [
	^ self mooseName = #'ActiveRecord::Base'
]

{ #category : #accessing }
GtRubyClass >> isAnActiveRecord [
	^ self withSuperclassHierarchy anySatisfy: #isActiveRecordBase
]

{ #category : #accessing }
GtRubyClass >> isRubyClass [
	^ true
]

{ #category : #'as yet unclassified' }
GtRubyClass >> rubyContainer: aContainerEntity [
	self container: aContainerEntity.
	^ super rubyContainer: aContainerEntity
]
