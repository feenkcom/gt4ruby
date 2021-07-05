Class {
	#name : #GtRubyActiveRecordAttribute,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'tableColumn'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyActiveRecordAttribute >> tableColumn [
	<MSEProperty: #tableColumn type: #GtTableColumn>
	^ tableColumn
]

{ #category : #accessing }
GtRubyActiveRecordAttribute >> tableColumn: aTableColumn [
	tableColumn := aTableColumn
]
