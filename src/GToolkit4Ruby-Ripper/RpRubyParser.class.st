Class {
	#name : #RpRubyParser,
	#superclass : #SmaCCParser,
	#category : #'GToolkit4Ruby-Ripper-Parser'
}

{ #category : #'file types' }
RpRubyParser class >> fileExtension [
	^ '.rb'
]

{ #category : #parsing }
RpRubyParser class >> parseFile: aFile [
	^ GtRpRubyImporter new parseFile: aFile asFileReference
]

{ #category : #accessing }
RpRubyParser class >> scannerClass [
	^ RpRubyScanner
]
