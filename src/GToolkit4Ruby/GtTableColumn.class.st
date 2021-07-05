Class {
	#name : #GtTableColumn,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'rubyActiveRecordAttribute'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtTableColumn >> rubyActiveRecordAttribute [
	<MSEProperty: #rubyActiveRecordAttribute type: #GtRubyActiveRecordAttribute>
	^ rubyActiveRecordAttribute
]

{ #category : #accessing }
GtTableColumn >> rubyActiveRecordAttribute: aRubyActiveRecordAttribute [
	rubyActiveRecordAttribute := aRubyActiveRecordAttribute
]
