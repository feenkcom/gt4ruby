Class {
	#name : 'GtNotifyingStyler',
	#superclass : 'GtSmaCCParserStyler',
	#instVars : [
		'notification'
	],
	#category : 'GToolkit4Ruby-Slides'
}

{ #category : 'initialization' }
GtNotifyingStyler >> initialize [
	super initialize.
	notification := [  ]
]

{ #category : 'accessing' }
GtNotifyingStyler >> notify: aBlock [
	notification := aBlock
]

{ #category : 'private' }
GtNotifyingStyler >> styleAST: anAST [
	super styleAST: anAST.
	notification value
]
