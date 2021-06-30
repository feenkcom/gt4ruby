Class {
	#name : #FAMIXRubySourceLanguage,
	#superclass : #FAMIXSourceLanguage,
	#category : #'GToolkit4Ruby-Model'
}

{ #category : #accessing }
FAMIXRubySourceLanguage >> gtASTNodeFor: aString at: anInterval [
	| ast |
	ast := GtRubyParser parseFile: aString.
	ast
		withAllNodesDo: [ :each | 
			(anInterval first <= each startPosition
				and: [ anInterval last = each stopPosition ])
				ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : #accessing }
FAMIXRubySourceLanguage >> gtStyler [
	^ GtRubyParser gtStyler
]
