Extension { #name : #MooseModel }

{ #category : #'*GToolkit4Ruby' }
MooseModel >> gtAllRubyClassesFor: aView [
	<gtView>
	self allRubyClasses isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Ruby classes';
		priority: 1;
		items: [ self allRubyClasses sorted: [:a :b | a name < b name ] ];
		column: 'Name' text: #name;
		column: 'Methods' text: [ :each | each methods size ];
		column: 'Attributes' text: [ :each | each attributes size ];
		column: 'ActiveRecord' text: [ :each | each isAnActiveRecord ifFalse: [''] ifTrue: ['yes'] ]
]
