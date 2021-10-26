Class {
	#name : #GtRubyActiveRecordAttribute,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'tableColumn'
	],
	#category : 'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyActiveRecordAttribute >> gtSourceFor: aView [
	<gtView>
	^ self tableColumn notNil 
		ifFalse: [ aView empty ]
		ifTrue: [ self tableColumn gtSourceFor: aView ]
]

{ #category : #accessing }
GtRubyActiveRecordAttribute >> tableColumn [
	<MSEProperty: #tableColumn type: #GtTableColumn>
	^ tableColumn
]

{ #category : #accessing }
GtRubyActiveRecordAttribute >> tableColumn: aTableColumn [
	tableColumn := aTableColumn
]
