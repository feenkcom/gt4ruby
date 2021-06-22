Extension { #name : #GtSmaCCParserStyler }

{ #category : #'*GToolkit4Ruby' }
GtSmaCCParserStyler class >> rubyStyler: aParserClass [
	<smaccStyler: #GtRubyParser priority: 50>
	^ (self forParser: aParserClass)
		stylerRules:
			{(GtSmaCCKeywordTokensStylerRule
				styleBlock: [ :styler | 
					styler
						bold;
						foreground: Color purple ]).
			(GtSmaCCCommentStylerRule
				styleBlock: [ :styler | styler foreground: Color lightGray ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RubyNumberNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RubyStringNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RubyRegexNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RubyXStringNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeVariableStylerRule
				nodeClassName: #SmaCCErrorNode
				variableNames: #(dismissedTokens errorToken)
				styleBlock: [ :styler | styler foreground: Color red ])}
]
