Class {
	#name : #RpRubyProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #accessing }
RpRubyProgramNode class >> parserClass [
	^ RpRubyParser
]

{ #category : #generated }
RpRubyProgramNode >> acceptVisitor: aVisitor [
	^ aVisitor visitProgram: self
]
