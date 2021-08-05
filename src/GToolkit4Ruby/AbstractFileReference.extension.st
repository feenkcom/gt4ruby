Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit4Ruby' }
AbstractFileReference >> gtRubySyntaxExplanationFor: aView [
	<gtView>
	(self extension = 'rb' and: [ self exists ])
		ifFalse: [ aView empty ].
	^ aView explicit
		title: 'Syntax Explanation' translated;
		stencil: [ GtRubySyntaxExplainer onSource: self contents ]
]
