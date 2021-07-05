Class {
	#name : #GtTable,
	#superclass : #FAMIXType,
	#instVars : [
		'rubyActiveRecordClass'
	],
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtTable >> rubyActiveRecordClass [
	<MSEProperty: #rubyActiveRecordClass type: #GtRubyClass>
	^ rubyActiveRecordClass
]

{ #category : #accessing }
GtTable >> rubyActiveRecordClass: aRubyClass [
	rubyActiveRecordClass := aRubyClass	
]
