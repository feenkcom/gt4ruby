Class {
	#name : #GtTableColumn,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'rubyActiveRecordAttribute',
		'foreignKey'
	],
	#category : 'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtTableColumn >> foreignKey [
	<MSEProperty: #foreignKey type: #GtTable opposite: #foreignKeyReferences>
	^ foreignKey
]

{ #category : #accessing }
GtTableColumn >> foreignKey: aTable [
	foreignKey := FMMultivalueLink
		on: self
		update: #foreignKeyReferences
		from: self foreignKey
		to: aTable
]

{ #category : #accessing }
GtTableColumn >> gtSourceFor: aView [
	^ self gtASTNode notNil 
		ifFalse: [ aView empty ]
		ifTrue: [ self gtASTNode gtSourceFor: aView ]
]

{ #category : #accessing }
GtTableColumn >> rubyActiveRecordAttribute [
	<MSEProperty: #rubyActiveRecordAttribute type: #GtRubyActiveRecordAttribute>
	^ rubyActiveRecordAttribute
]

{ #category : #accessing }
GtTableColumn >> rubyActiveRecordAttribute: aRubyActiveRecordAttribute [
	rubyActiveRecordAttribute := aRubyActiveRecordAttribute
]
