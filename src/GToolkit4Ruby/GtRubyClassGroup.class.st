Class {
	#name : #GtRubyClassGroup,
	#superclass : #FAMIXClassGroup,
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyClassGroup >> gtAllActiveRecordConnectionsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Active record connections';
		painting: [ :m | 
			m nodes
				stencil: [ :c | 
					BlTextElement new
						zIndex: 10;
						text:
							(c name asRopedText glamorousRegularFont
								foreground:
									(self = c
										ifTrue: [ Color blue ]
										ifFalse: [ Color black ])) ];
				with: (self select: [:each | each isAnActiveRecord ]).
			m edges
				fromRightCenter;
				toLeftCenter;
				stencil: [:class | 
					BlParabollaArcElement new 
						zIndex: 0;
						curvatureFraction: 0.1;
						border: (BlBorder paint: (Color orange alpha: 0.8) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color orange alpha: 0.8); width: 2; build)) ];
				connectFrom: [ :class | class ]
					toAll: [ :class | 
					class attributes
						select: [ :each | each declaredType notNil ]
						thenCollect: [ :each | each declaredType ] ].
			m layout horizontalDominanceTree
				levelDistance: 50;
				nodeDistance: 0 ]
]
