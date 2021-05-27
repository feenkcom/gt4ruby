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
		do: [
			spec 
				baseline: 'GToolkit4Ruby' with: [ spec repository: 'github://feenkcom/gt4ruby/src' ] ]
]
