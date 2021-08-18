Extension { #name : 'GtSmaCCParserStyler' }

{ #category : '*GToolkit4Ruby' }
GtSmaCCParserStyler class >> rpRubyStyler: aParserClass [
	<smaccStyler: #RpRubyParser priority: 50>
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
				nodeClassName: #RpRubyNumberNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RpRubyStringNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RpRubyRegexNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeStylerRule
				nodeClassName: #RpRubyXStringNode
				styleBlock: [ :styler | styler foreground: Color blue ]).
			(GtSmaCCNodeVariableStylerRule
				nodeClassName: #SmaCCErrorNode
				variableNames: #(dismissedTokens errorToken)
				styleBlock: [ :styler | styler foreground: Color red ])}
]
