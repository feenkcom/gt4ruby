Class {
	#name : #GtRubyClass,
	#superclass : #FAMIXClass,
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #'as yet unclassified' }
GtRubyClass >> rubyContainer: aContainerEntity [
	self container: aContainerEntity.
	^ super rubyContainer: aContainerEntity
]
