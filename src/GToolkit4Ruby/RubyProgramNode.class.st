Class {
	#name : #RubyProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #accessing }
RubyProgramNode class >> parserClass [
	^ GtRubyParser
]

{ #category : #generated }
RubyProgramNode >> acceptVisitor: aVisitor [
	^ aVisitor visitProgram: self
]
