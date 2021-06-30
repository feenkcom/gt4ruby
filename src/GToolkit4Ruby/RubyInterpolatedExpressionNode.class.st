Class {
	#name : #RubyInterpolatedExpressionNode,
	#superclass : #RubyProgramNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'GToolkit4Ruby-AST'
}

{ #category : #generated }
RubyInterpolatedExpressionNode >> acceptVisitor: aVisitor [
	^ aVisitor visitInterpolatedExpression: self
]

{ #category : #generated }
RubyInterpolatedExpressionNode >> left [
	^ left
]

{ #category : #generated }
RubyInterpolatedExpressionNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RubyInterpolatedExpressionNode >> right [
	^ right
]

{ #category : #generated }
RubyInterpolatedExpressionNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RubyInterpolatedExpressionNode >> tokenVariables [
	^ #(left right)
]
