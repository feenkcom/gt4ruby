Class {
	#name : #RpRubyInterpolatedExpressionNode,
	#superclass : #RpRubyProgramNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'GToolkit4Ruby-Ripper-AST'
}

{ #category : #generated }
RpRubyInterpolatedExpressionNode >> acceptVisitor: aVisitor [
	^ aVisitor visitInterpolatedExpression: self
]

{ #category : #generated }
RpRubyInterpolatedExpressionNode >> left [
	^ left
]

{ #category : #generated }
RpRubyInterpolatedExpressionNode >> left: aToken [
	left := aToken
]

{ #category : #generated }
RpRubyInterpolatedExpressionNode >> right [
	^ right
]

{ #category : #generated }
RpRubyInterpolatedExpressionNode >> right: aToken [
	right := aToken
]

{ #category : #generated }
RpRubyInterpolatedExpressionNode >> tokenVariables [
	^ #(left right)
]
