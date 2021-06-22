Class {
	#name : #GtRubyScanner,
	#superclass : #SmaCCScanner,
	#category : #GToolkit4Ruby
}

{ #category : #'class initialization' }
GtRubyScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	keywordMap
		at: 1
		put:
			(self keywords
				inject: Dictionary new
				into: [ :sum :each | 
					sum
						at: each put: 2;
						yourself ])
]

{ #category : #private }
GtRubyScanner class >> keywords [
	^ #('BEGIN' 'END' '__ENCODING__' '__FILE__' '__LINE__' 'alias' 'and' 'begin' 'break' 'case' 'class' 'def' 'defined' 'do' 'else' 'elsif' 'end' 'ensure' 'false' 'for' 'if' 'in' 'module' 'next' 'nil' 'not' 'or' 'redo' 'rescue' 'retry' 'return' 'self' 'super' 'then' 'true' 'undef' 'unless' 'until' 'when' 'while' 'yield')
]
