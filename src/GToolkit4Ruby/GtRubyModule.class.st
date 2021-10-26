Class {
	#name : #GtRubyModule,
	#superclass : #FAMIXNamespace,
	#category : 'GToolkit4Ruby-Model'
}

{ #category : #'as yet unclassified' }
GtRubyModule >> rubyContainer: aContainerEntity [
	(aContainerEntity isKindOf: GtRubyModule)
		ifTrue: [ self parentScope: aContainerEntity ].
	^ super rubyContainer: aContainerEntity
]
