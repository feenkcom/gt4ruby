Class {
	#name : #BaselineOfGToolkit4Ruby,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Ruby
}

{ #category : #baseline }
BaselineOfGToolkit4Ruby >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'SmaCC_Mysql';
				package: 'GToolkit4Ruby' with: [ spec requires: 'SmaCC_Mysql' ] ]
]
