Class {
	#name : #GtRubyClass,
	#superclass : #FAMIXClass,
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
GtRubyClass >> isActiveRecordBase [
	^ self mooseName = #'ActiveRecord::Base'
]

{ #category : #accessing }
GtRubyClass >> isAnActiveRecord [
	^ self withSuperclassHierarchy anySatisfy: #isActiveRecordBase
]

{ #category : #'as yet unclassified' }
GtRubyClass >> rubyContainer: aContainerEntity [
	self container: aContainerEntity.
	^ super rubyContainer: aContainerEntity
]
