Class {
	#name : #GtRubyRouteGroup,
	#superclass : #MooseGroup,
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyRouteGroup >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		priority: 0;
		items: [ self entities sorted: [ :a :b | a path gtDisplayString < b path gtDisplayString ] ];
		title: 'Items';
		column: 'Path' text: [ :each | each path ] weight: 2;
		column: 'Verb' translated text: [ :each | each verb ] width: 50;
		column: 'Method' text: [ :each | each method ifNil: [''] ]
]
