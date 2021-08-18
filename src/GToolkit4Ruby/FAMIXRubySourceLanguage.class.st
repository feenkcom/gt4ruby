Class {
	#name : 'FAMIXRubySourceLanguage',
	#superclass : 'FAMIXSourceLanguage',
	#category : 'GToolkit4Ruby-Model'
}

{ #category : 'private' }
FAMIXRubySourceLanguage >> gtASTNodeFor: aString at: anInterval [
	| ast |
	ast := RubyParser parseWithErrors: aString.
	ast
		withAllNodesDo: [ :each | 
			(anInterval first <= each startPosition
				and: [ anInterval last = each stopPosition ])
				ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : 'private' }
FAMIXRubySourceLanguage >> gtStyler [
	^ RubyParser gtStyler
]
