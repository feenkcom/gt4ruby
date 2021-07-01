Extension { #name : #FAMIXContainerEntity }

{ #category : #'*GToolkit4Ruby' }
FAMIXContainerEntity >> rubyContainer [
	<MSEProperty: #rubyContainer type: #FAMIXContainerEntity opposite: #rubyEntities>
	<MSEComment:
		'Ruby container entity to which this type belongs to. Container is a Ruby module or class.'>
	^ self privateState attributeAt: #gtRubyContainer ifAbsent: [  ]
]

{ #category : #'*GToolkit4Ruby' }
FAMIXContainerEntity >> rubyContainer: aContainerEntity [
	^ self privateState
		attributeAt: #gtRubyContainer
		put:
			(FMMultivalueLink
				on: self
				update: #rubyEntities
				from: self rubyContainer
				to: aContainerEntity)
]

{ #category : #'*GToolkit4Ruby' }
FAMIXContainerEntity >> rubyEntities [
	<MSEProperty: #rubyEntities type: #FAMIXContainerEntity opposite: #rubyContainer>
	<multivalued>
	<MSEComment: 'Return the Ruby modules and classes'>
	^ self privateState
		attributeAt: #gtRubyEntities
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #rubyContainer: ]
]

{ #category : #'*GToolkit4Ruby' }
FAMIXContainerEntity >> rubyEntities: aCollection [
	self rubyEntities value: aCollection
]
