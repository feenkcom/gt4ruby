Class {
	#name : #GtTable,
	#superclass : #FAMIXType,
	#instVars : [
		'rubyActiveRecordClass',
		'foreignKeyReferences'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtTable >> foreignKeyReferences [
	<MSEProperty: #foreignKeyReferences type: #GtTableColumn opposite: #foreignKey> <multivalued> <derived>
	^foreignKeyReferences
]

{ #category : #accessing }
GtTable >> foreignKeyReferences: aCollection [
	foreignKeyReferences value: aCollection
]

{ #category : #views }
GtTable >> gtIncomingReferencesFor: aView [
	<gtView>
	^ aView columnedList
		priority: 1;
		title: 'Incoming references';
		items: [ self incomingReferences ];
		column: 'From' text: [ :each | each from gtDisplayString ];
		column: 'To' text: [ :each | each to gtDisplayString ]
]

{ #category : #accessing }
GtTable >> initialize [
	super initialize.
	foreignKeyReferences := FMNullMultivalueLink on: self opposite: #foreignKey: selector: #foreignKeyReferences
]

{ #category : #accessing }
GtTable >> rubyActiveRecordClass [
	<MSEProperty: #rubyActiveRecordClass type: #GtRubyClass>
	^ rubyActiveRecordClass
]

{ #category : #accessing }
GtTable >> rubyActiveRecordClass: aRubyClass [
	rubyActiveRecordClass := aRubyClass	
]
