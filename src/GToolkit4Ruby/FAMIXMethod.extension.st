Extension { #name : 'FAMIXMethod' }

{ #category : '*GToolkit4Ruby' }
FAMIXMethod >> routes [
	<MSEProperty: #routes type: #GtRubyRoute opposite: #method>
	<multivalued>
	^ self privateState
		attributeAt: #gtRubyRoutes
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #method: ]
]

{ #category : '*GToolkit4Ruby' }
FAMIXMethod >> routes: aCollection [
	self routes value: aCollection
]
