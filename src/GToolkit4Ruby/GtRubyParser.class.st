Class {
	#name : #GtRubyParser,
	#superclass : #SmaCCParser,
	#category : #GToolkit4Ruby
}

{ #category : #'file types' }
GtRubyParser class >> fileExtension [
	^ '.rb'
]

{ #category : #parsing }
GtRubyParser class >> parseFile: aFile [
	^ GtRubyImporter new parseFile: aFile asFileReference
]

{ #category : #accessing }
GtRubyParser class >> scannerClass [
	^ GtRubyScanner
]
