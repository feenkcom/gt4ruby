require "ripper"

class Token
	@line = 0
	@column = 0
	@value = ""

	def initialize(l,c,s)
		@line = l
		@column = c
		@value = s
	end

	def hasValue?(s)
		@value == s
	end

	def getValue()
		@value
	end

	def getLine()
		@line
	end

	def getColumn() 
		@column
	end
end

class Node
	@type = ""

	def initialize(s)
		@type = s
		@tokens = Hash.new
		@nodes = Hash.new
	end
	
	def getToken(name)
		@tokens[name]
	end
	
	def getTokenNames()
		@tokens.keys
	end

	def getNode(name)
		@nodes[name]
	end

	def getNodeNames()
		@nodes.keys
	end

	def getNodeType
		@type
	end

	def token(name, token) 
		@tokens[name] = token
	end

	def node(name, node) 
		@nodes[name] = node
	end

	def addNode(name, node)
		if (!@nodes.include?(name))
			@nodes[name] = Array.new
		end
		@nodes[name].push(node)
	end

	def prependNode(name, node)
		if (!@nodes.include?(name))
			@nodes[name] = Array.new
		end
		@nodes[name].unshift(node)
	end

	def addToken(name, token)
		if (!@tokens.include?(name))
			@tokens[name] = Array.new
		end
		@tokens[name].push(token)
	end

	def prependToken(name, token)
		if (!@tokens.include?(name))
			@tokens[name] = Array.new
		end
		@tokens[name].unshift(token)
	end

	def isType?(t)
		@type == t
	end
end

class ASTBuilder < Ripper
	def initialize(source)
		super(source)
		@stack = Array.new
		@comments = Array.new
		@embeddedDoc = Array.new
	end

	def getStack()
		@stack
	end

	def isValidParsedStack?()
		@stack.count == 1
	end

	def isTokenValue?(token, s)
		token.is_a?(Token) && token.hasValue?(s)
	end

	def isNodeOfType?(node, t)
		node.is_a?(Node) && node.isType?(t)
	end

	def pushItems(popped)
		while popped.count > 0
			push(popped.pop)
		end
	end

	def push(item)
		@stack.push(item)
	end

	def popUntil(&block)
		popped = Array.new
		begin
			if @stack.count == 0
				raise "Stack is empty"
			end
			item = @stack.pop
			popped.push(item)
		end while !block.call(item)
		popped
	end

	def popUntilToken(s)
		popUntil {|item| isTokenValue?(item, s)}
	end

	def popUntilNode(n)
		popUntil {|item| item == n}
	end

	def on_var_field(t)
		node = Node.new("Variable")
		node.token("name", t)
		popped = popUntilNode(t)
		popped.pop
		push(node)
		pushItems(popped)
		node 
	end

	alias_method :on_var_ref, :on_var_field
	alias_method :on_vcall, :on_var_field
	alias_method :on_const_ref, :on_var_field

	def on_const_path_ref(rcvr, name)
		node = Node.new("ConstPath")
		popped = popUntilNode(rcvr)
		node.node("receiver", popped.pop)
		node.token("separator", popped.pop)
		node.token("name", popped.pop)
		push(node)
		pushItems(popped)
		node
	end
	
	alias_method :on_const_path_field, :on_const_path_ref

	def on_top_const_ref(name)
		node = Node.new("ConstPath")
		popped = popUntilNode(name)
		node.token("separator", @stack.pop)
		node.token("name", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	alias_method :on_top_const_field, :on_top_const_ref

	def on_blockarg(t)
		node = Node.new("BlockArgVariable")
		node.token("name", t)
		popped = popUntilToken("&")
		node.token("amp", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_rest_param(t)
		node = Node.new("RestVariable")
		node.token("name", t)
		popped = popUntilToken("*")
		node.token("star", popped.pop)
		popped.pop if t != nil
		push(node)
		pushItems(popped)
		node
	end

	def on_kwrest_param(t)
		node = Node.new("RestVariable")
		popped = popUntilToken("**")
		node.token("star", popped.pop)
		node.token("name", popped.pop) if t != nil
		push(node)
		pushItems(popped)
		node
	end

	def on_nokw_param(t)
		node = Node.new("RestVariable")
		popped = popUntilToken("**")
		node.token("star", popped.pop)
		node.token("name", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_assoc_new(key, value)
		node = Node.new("Association")
		node.node("key", key)
		node.node("value", value)
		popped = popUntilNode(key)
		popped.pop
		if isTokenValue?(popped.last, "=>")
			node.token("arrow", popped.pop)
		end
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_assoclist_from_args(args)
		node = Node.new("Hash")
		node.node("associations", args)
		popped = popUntilToken("{")
		push(node)
		node.token("left", popped.pop)
		commas = Array.new
		begin 
			if popped.count == 0
				raise "Stack is empty"
			end
			item = popped.pop
			if isTokenValue?(item, ",")
				commas.push(item)
			end
		end while !(isTokenValue?(item, "}") || popped.count == 0)
		node.token("commas", commas)
		node.token("right", item) if isTokenValue?(item, "}")
		pushItems(popped)
		node
	end

	def on_hash(node)
		if node == nil
			node = Node.new("Hash")
			popped = popUntilToken("{")
			push(node)
			node.token("left", popped.pop)
			node.token("right", popped.pop)
			pushItems(popped)
		end
		node
	end

	def on_heredoc_dedent(values, i)
		node = Node.new("HeredocDedent")
		popped = popUntilNode(values)
		node.token("start", @stack.pop)
		popped.pop
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_stmts_new
		node = Array.new
		node.push(Array.new)
		node.push(Array.new)
		node
	end

	def on_stmts_add(list, stmt)
		if stmt == nil
			return list
		end
		list[0].push(stmt)
		popped = popUntilNode(stmt)
		popped.pop
		while isTokenValue?(@stack.last, ";")
			popped.push(@stack.pop)
		end
		if @stack.last != list
			push(list)
		end
		while isTokenValue?(popped.last, ";")
			list[1].push(popped.pop)
		end
		pushItems(popped)
		list
	end

	def on_program(statements)
		node = Node.new("File")
		node.node("statements", statements[0])
		node.token("semicolons", statements[1])
		node.token("comments",@comments)
		node.token("embeddedDocumentItems", @embeddedDoc)
		if @endToken != nil
			node.token("__end__",@endToken)
		end
		popped = popUntilNode(statements)
		popped.pop
		while isTokenValue?(popped.last, ";")
			statements[1].push(popped.pop)
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_assign(var, value) 
		node = Node.new("Assignment")
		node.node("lhs", var)
		node.node("value", value)
		popped = popUntilNode(var)
		popped.pop
		node.token("assignment", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_opassign(var, token, value) 
		node = Node.new("Assignment")
		node.node("lhs", var)
		node.node("value", value)
		popped = popUntilNode(var)
		popped.pop
		node.token("assignment", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_binary(left, op, right)
		node = Node.new("Binary")
		node.node("left", left)
		node.node("right", right)
		popped = popUntilNode(left)
		popped.pop
		node.token("operator", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node 
	end

	def on_lambda(args, statements)
		node = Node.new("Lambda")
		node.node("block", statements)
		popped = popUntilToken("->")
		node.token("arrow", popped.pop)
		node.node("parameters", popped.pop)
		node.token("left", popped.pop)
		popped.pop
		node.token("right", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_array(list)
		node = Node.new("Array")
		quotes = 0
		popped = popUntil do |item| 
			quotes = quotes + 1 if item.is_a?(Token) && "'\"/!$|".include?(item.getValue()[-1])
			item.is_a?(Token) && ("([{<".include?(item.getValue()[-1]) || quotes == 2)
		end
		if list != nil && list[0].is_a?(Array) && list[1].is_a?(Array) && list[1].all? {| item | isTokenValue?(item, ",")}
			node.node("values", list[0])
			node.token("commas", list[1])
		elsif list != nil
			node.node("values", list.flatten())
		end
		node.token("leftBracket", popped.pop)
		begin
			if popped.count == 0
				raise "The stack is empty"
			end
			item = popped.pop 
		end while !(item.is_a?(Token) && ")]}>'\"/!$|".include?(item.getValue()[-1]))
		node.token("rightBracket", item)
		push(node)
		pushItems(popped)
		node
	end

	def on_string_content()
		node = Array.new
		push(node)
		node
	end

	def on_string_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		if @stack.last != list && popped.last != list
			push(list)
		end
		pushItems(popped)
		list
	end

	def convertToPartNodes(parts)
		for i in 0..(parts.count-1)
			if parts[i].is_a?(Token)
				node = Node.new("Part")
				node.token("part", parts[i])
				parts[i] = node
			end
		end
		parts
	end

	def on_string_literal(parts)
		node = Node.new("String")
		items = Array.new
		items.push(parts)
		if isNodeOfType?(@stack.last, "HeredocDedent")
			@stack.last.node("string", node)
			node.node("parts", convertToPartNodes(items.flatten))
			@stack.last
		else
			items.push(@stack.pop)
			@stack.pop
			items.unshift(@stack.pop)
			push(node)
			node.node("parts", convertToPartNodes(items.flatten))
			node
		end
	end

	def on_dyna_symbol(parts)
		node = Node.new("DynamicSymbol")
		items = Array.new
		items.push(parts)
		popped = popUntilNode(parts)
		items.unshift(@stack.pop)
		popped.pop
		items.push(popped.pop)
		node.node("parts", convertToPartNodes(items.flatten))
		push(node)
		pushItems(popped)
		node
	end

	def on_arg_paren(args)
		node = Node.new("Arguments")
		if (args != nil)
			if args.is_a?(Node)
				node.node("arguments", [args])
			else
				node.node("arguments", args[0])
				node.token("commas", args[1])
			end
		end
		popped = popUntilToken("(")
		node.token("left", popped.pop)
		popped.pop
		node.token("right", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_method_add_arg(call, args) 
		popped = popUntilNode(call)
		push(popped.pop)
		if args.is_a?(Array)
			if isNodeOfType?(popped.last, "Arguments")
				call.node("arguments", popped.pop)
			end
		else
			call.node("arguments", args)
			popped.pop
		end
		pushItems(popped)
		call
	end

	def on_block_var(arg, ign)
		right = @stack.pop
		popped = popUntil {|each| isNodeOfType?(each, "Params")}
		vars = popped.pop
		left = @stack.pop
		if !vars.is_a?(Node)
			raise "error"
		end
		vars.token("right", right)
		vars.token("left", left)
		push(vars)
		vars
	end

	def on_defined(var)
		node = Node.new("Defined")
		node.node("variable", var)
		popped = popUntilToken("defined?")
		node.token("defined", popped.pop)
		hasParens = isTokenValue?(popped.last, "(")
		node.token("left", popped.pop) if hasParens
		popped.pop
		node.token("right", popped.pop) if hasParens
		@stack.push(node)
		pushItems(popped)
		node
	end

	def on_fcall(name)
		node = Node.new("Call")
		node.token("name", name) 
		popped = popUntilNode(name)
		push(node)
		popped.pop
		pushItems(popped)
		node
	end

	def on_call(rcvr, period, name)
		node = Node.new("Call")
		node.node("receiver", rcvr)
		node.token("period", period)
		node.token("name", name) 
		popped = popUntilNode(rcvr)
		push(node)
		popped.pop
		popped.pop
		popped.pop if rcvr != nil
		pushItems(popped)
		node
	end

	def on_excessed_comma()
		nil
	end

	def on_params(params, optionalParams, restVariable, paramsAfterRest, keywordParams, keywordRestVariable, blockVariable)
		node = Node.new("Params")
		nodes = Array.new
		optional = Array.new
		endingToken = nil
		first = blockVariable
		if blockVariable != nil
			nodes.push(blockVariable)
		end
		if keywordRestVariable != nil
			first = keywordRestVariable
			if !keywordRestVariable.is_a?(Node)
				i = @stack.size - 1
				i -= 1 while !isNodeOfType?(@stack[i], "RestVariable")
				first = @stack[i]
			end
			nodes.unshift(first)
		end
		if keywordParams != nil
			first = keywordParams[0][0]
			(keywordParams.count - 1).downto(0) {|i|
				var = Node.new("KeywordVariable")
				var.node("label", keywordParams[i][0])
				if keywordParams[0][1] != false
					var.node("value", keywordParams[i][1])
				end
				nodes.unshift(var)
			}
		end
		if paramsAfterRest != nil
			(paramsAfterRest.count - 1).downto(0) {|i|
				var = Node.new("Variable")
				var.token("name", paramsAfterRest[i])
				nodes.unshift(var)
			}
		end
		if restVariable != nil
			first = restVariable
			nodes.unshift(restVariable)
		end
		if optionalParams != nil
			first = optionalParams[0][0]
			(optionalParams.count - 1).downto(0) do |i| 
				var = Node.new("OptionalVariable")
				var.token("name", optionalParams[i][0])
				var.node("value", optionalParams[i][1])
				nodes.unshift(var)
				optional.unshift(var)
			end
		end
		if params != nil
			first = params[0]
			(params.count - 1).downto(0) do |i|
				var = Node.new("Variable")
				var.token("name", params[i])
				nodes.unshift(var)
			end
		end
		commas = Array.new
		popped = Array.new
		if first != nil
			begin
				if @stack.count == 0
					raise "Stack is empty"
				end
				item = @stack.pop
				popped.push(item)
				if isTokenValue?(item, ",")
					commas.push(item)
				elsif isTokenValue?(item, "=")
					optional.pop.token("equals", item)
				elsif isTokenValue?(item,"|") || isTokenValue?(item, ")")
					endingToken = item
				end
			end while item != first
			node.token("commas", commas)
			node.node("variables", nodes)
		else
			if isTokenValue?(@stack.last, "|") || isTokenValue?(@stack.last, ")")
				endingToken = @stack.pop
			end
		end
		push(node)
		if endingToken != nil
			push(endingToken)
		end
		value = Array.new
		value.push(Array.new)
		value[0].push(node)
		value
	end

	def on_args_new
		node = Array.new
		node.push(Array.new)
		node.push(Array.new)
		node
	end

	def on_args_add(list, node)
		list[0].push(node)
		popped = popUntilNode(node)
		if @stack.last != list
			push(list)
		end
		popped.pop
		if isTokenValue?(popped.last, ",")
			list[1].push(popped.pop)
		end
		pushItems(popped)
		list
	end

	def on_args_add_star(list, var)
		node = Node.new("SplatVariable")
		node.node("variable", var)
		list[0].push(node)
		popped = popUntilToken("*")
		if @stack.last != list
			push(list)
		end
		node.token("star", popped.pop)
		popped.pop
		if isTokenValue?(popped.last, ",")
			list[1].push(popped.pop)
		end
		pushItems(popped)
		list
	end

	def on_args_add_block(list, node)
		if node == false
			if !@stack.include?(list)
				push(list)
			end
			return list
		end
		newNode = Node.new("BlockArgument")
		newNode.node("value", node)
		list[0].push(newNode)
		popped = popUntilNode(node)
		newNode.token("amp", @stack.pop)
		if @stack.last != list
			push(list)
		end
		popped.pop
		if isTokenValue?(popped.last, ",")
			list[1].push(popped.pop)
		end
		pushItems(popped)
		list
	end

	def on_rescue_mod(exp, value)
		node = Node.new("RescueMod")
		node.node("expression", exp)
		node.node("value", value)
		popped = popUntilNode(exp)
		popped.pop
		node.token("rescue", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_until_mod(exp, stmt)
		node = Node.new("UntilMod")
		node.node("condition", exp)
		node.node("statement", stmt)
		popped = popUntilNode(stmt)
		push(node)
		popped.pop
		node.token("untilToken", popped.pop)
		popped.pop
		pushItems(popped)
		node
	end

	def on_if_mod(exp, stmt)
		node = Node.new("IfMod")
		node.node("condition", exp)
		node.node("statement", stmt)
		popped = popUntilNode(stmt)
		push(node)
		popped.pop
		node.token("ifToken", popped.pop)
		popped.pop
		pushItems(popped)
		node
	end

	def on_unless_mod(exp, stmt)
		node = Node.new("UnlessMod")
		node.node("condition", exp)
		node.node("statement", stmt)
		popped = popUntilNode(stmt)
		push(node)
		popped.pop
		node.token("unlessToken", popped.pop)
		popped.pop
		pushItems(popped)
		node
	end

	def on_return(value)
		node = Node.new("Return")
		node.node("values", value[0])
		node.token("commas", value[1])
		popped = popUntilToken("return")
		node.token("return", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_return0()
		node = Node.new("Return")
		popped = popUntilToken("return")
		node.token("return", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_paren(items)
		popped = popUntilToken("(")
		leftParen = popped.pop
		popped.pop if items != false
		rightParen = popped.pop
		node = items.is_a?(Node) ? items : items[0][0] if items != false
		if node.is_a?(Token)
			var = Node.new("Variable")
			var.token("name", node)
			node = var
		end
		if node == nil
			node = Node.new("Arguments")
		end
		node.prependToken("leftParens", leftParen)
		node.addToken("rightParens", rightParen)
		push(node)
		pushItems(popped)
		node
	end

	def on_do_block(params, stmts)
		node = Node.new("Block")
		node.node("variables", params)
		node.node("body", stmts)
		popped = popUntilToken("do")
		node.token("do", popped.pop)
		begin
			item = popped.pop
		end while !isTokenValue?(item, "end")
		node.token("end", item)
		push(node)
		pushItems(popped)
		node
	end

	def on_brace_block(params, stmts)
		node = Node.new("Block")
		node.node("variables", params)
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("{")
		node.token("left", popped.pop)
		commas = Array.new
		begin
			if popped.count == 0
				raise "The stack is empty"
			end
			item = popped.pop
			if isTokenValue?(item, ",")
				commas.push(item)
			end
		end while !isTokenValue?(item, "}")
		node.token("right", item)
		node.token("commas", commas)
		push(node)
		pushItems(popped)
		node
	end

	def on_method_add_block(call, block)
		@stack.pop
		call.node("block", block)
		call
	end

	def on_bodystmt(stmts, rescueNode, rescueElseStmts, ensureNode)
		node = Node.new("StatementBlock")
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilNode(stmts)
		popped.pop
		if rescueNode != nil
			node.node("rescue",popped.pop)
			if rescueElseStmts != nil
				elseNode = Node.new("RescueElseNode")
				while !isTokenValue?(popped.last, "else") 
					if popped.count == 0
						raise "stack is empty"
					end
					popped.pop
				end
				elseNode.token("else", popped.pop)
				elseNode.node("statements", popped.last[0])
				elseNode.token("semicolons", popped.pop[1])
				node.addNode("rescueElse", elseNode)
			end
		end
		if ensureNode != nil
			node.node("ensure", popped.pop)
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_def(token, params, statements)
		node = Node.new("Method")
		node.node("block", statements)
		node.node("params", params)
		popped = popUntilToken("def")
		push(node)
		node.token("defToken", popped.pop)
		node.token("name", popped.pop)
		item = popped.pop while !isTokenValue?(item, "end")
		node.token("endToken", item)
		pushItems(popped)
		node
	end

	def on_defs(mod, period, token, params, statements)
		node = Node.new("Method")
		node.node("block", statements)
		node.node("params", params)
		popped = popUntilToken("def")
		push(node)
		node.token("defToken", popped.pop)
		node.node("module", popped.pop)
		node.token("period", popped.pop)
		node.token("name", popped.pop)
		item = popped.pop while !isTokenValue?(item, "end")
		node.token("endToken", item)
		pushItems(popped)
		node
	end

	def on_qwords_new()
		node = Array.new
		node.push(Array.new)
		node.push(Array.new)
		push(node)
		node
	end

	def on_qwords_add(list, token)
		string = Node.new("String")
		string.token("value",token)
		list[0].push(string)
		popped = popUntilNode(token)
		if @stack.last != list
			push(list)
		end
		popped.pop
		pushItems(popped)
		list
	end

	def on_words_new()
		node = Array.new
		push(node)
		node
	end

	def on_words_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		pushItems(popped)
		list
	end

	def on_word_new()
		node = Array.new
		push(node)
		node
	end

	def on_word_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		pushItems(popped)
		list
	end

	def on_qsymbols_new()
		node = Array.new
		push(node)
		node
	end

	def on_qsymbols_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		pushItems(popped)
		list
	end

	def on_symbols_new()
		node = Array.new
		push(node)
		node
	end

	def on_symbols_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		pushItems(popped)
		list
	end

	def on_xstring_new()
		node = Array.new
		push(node)
		node
	end

	def on_xstring_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		pushItems(popped)
		list
	end

	def on_xstring_literal(list)
		node = Node.new("XString")
		items = Array.new
		items.push(list)
		items.push(@stack.pop)
		@stack.pop
		items.unshift(@stack.pop)
		node.node("parts", convertToPartNodes(items.flatten))
		push(node)
		node
	end

	def on_regexp_new()
		node = Array.new
		push(node)
		node
	end

	def on_regexp_add(list, token)
		list.push(token)
		popped = popUntilNode(token)
		popped.pop
		pushItems(popped)
		list
	end

	def on_regexp_literal(list, token)
		node = Node.new("Regex")
		parts = Array.new
		parts.push(@stack.pop)
		begin
			if @stack.count == 0
				raise "Stack is empty"
			end
			item = @stack.pop
			parts.unshift(item)
		end while !(isTokenValue?(item, "/") || (item.is_a?(Token) && item.getValue().include?("%r")))
		node.node("parts", convertToPartNodes(parts))
		push(node)
		node
	end

	def on_unless(condition, stmts, elseStmt)
		node = Node.new("Unless")
		popped = popUntilToken("unless")
		node.token("unlessToken", popped.pop)
		node.node("condition", condition)
		node.node("thenStatements", stmts[0])
		node.token("semicolons", stmts[1])
		node.node("else", elseStmt)
		item = popped.pop until isTokenValue?(item, "end")
		node.token("end", item)
		push(node)
		pushItems(popped)
		node
	end

	def on_case(value, whenNode)
		node = Node.new("Case")
		node.node("value", value)
		node.node("when", whenNode)
		popped = popUntilToken("case")
		node.token("case", popped.pop)
		while !isTokenValue?(popped.last, "end") 
			if popped.count == 0 
				raise "Stack is empty"
			end
			popped.pop 
		end
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_when(conditions, stmts, elseNode)
		node = Node.new("When")
		node.node("conditions", conditions[0])
		node.token("commas", conditions[1])
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("when")
		node.token("when", popped.pop)
		popped.pop
		if isTokenValue?(popped.last, "then")
			node.token("then", popped.pop)
		end
		popped.pop
		if elseNode != nil
			node.node("next", elseNode)
			popped.pop
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_if(condition, stmts, elseNode)
		node = Node.new("If")
		popped = popUntilToken("if")
		node.token("ifToken", popped.pop)
		node.node("condition", condition)
		popped.pop
		if isTokenValue?(popped.last, "then")
			node.token("then", popped.pop)
		end
		node.node("thenStatements", stmts[0])
		node.token("semicolons", stmts[1])
		if elseNode != nil
			node.node("else", elseNode)
		end
		item = popped.pop until isTokenValue?(item, "end")
		node.token("end", item)
		push(node)
		pushItems(popped)
		node
	end

	def on_else(stmts)
		node = Node.new("Else")
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("else")
		push(node)
		node.token("else", popped.pop)
		popped.pop
		pushItems(popped)
		node
	end

	def on_elsif(condition,stmts,elseNode)
		node = Node.new("Elsif")
		node.node("condition", condition)
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		if elseNode != nil
			node.node("else", elseNode)
		end
		popped = popUntilToken("elsif")
		push(node)
		node.token("elsif", popped.pop)
		popped.pop
		popped.pop
		if elseNode != nil
			popped.pop
		end
		pushItems(popped)
		node
	end

	def on_aref(array, indices)
		node = Node.new("ArrayReference")
		node.node("array", array)
		if indices != nil
			node.node("indices", indices[0])
			node.token("commas", indices[1])
		end
		popped = popUntilNode(array)
		push(node)
		popped.pop
		node.token("left", popped.pop)
		popped.pop if indices != nil
		node.token("right", popped.pop)
		pushItems(popped)
		node
	end

	def on_aref_field(array, indices)
		node = Node.new("ArrayReference")
		node.node("array", array)
		node.node("indices", indices[0])
		node.token("commas", indices[1])
		popped = popUntilNode(array)
		push(node)
		popped.pop
		node.token("left", popped.pop)
		popped.pop
		node.token("right", popped.pop)
		pushItems(popped)
		node
	end

	def on_mrhs_new()
		node = Array.new
		node.push(Array.new)
		node.push(Array.new)
		push(node)
		node
	end

	def on_mrhs_add_star(values, value)
		node = Node.new("Splat")
		popped = popUntilToken("*")
		node.token("star", popped.pop)
		node.node("value", popped.pop)
		push(values) unless @stack.last == values
		push(node)
		popped.pop if popped.last == values
		pushItems(popped)
		on_mrhs_add(values, node)
	end

	def on_mlhs_new()
		node = Array.new
		node.push(Array.new)
		node.push(Array.new)
		node
	end

	def on_mlhs_add(vars, var)
		popped = popUntilNode(var)
		if (@stack.last != vars)
			push(vars)
		end
		vars[0].push(popped.pop)
		if isTokenValue?(popped.last, ",")
			vars[1].push(popped.pop)
		end
		pushItems(popped)
		vars
	end

	def on_mlhs_add_post(varsBefore, varsAfter)
		popped = popUntilNode(varsAfter)
		varsBefore[0].push(*varsAfter[0])
		varsBefore[1].push(*varsAfter[1])
		popped.pop
		pushItems(popped)
		varsBefore
	end

	def on_mlhs_paren(vars)
		node = Node.new("LhsVariables")
		popped = popUntilToken("(")
		node.token("left", popped.pop)
		node.node("variables", vars[0])
		node.token("commas", popped.pop[1])
		node.token("right", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_mlhs_add_star(vars, var)
		node = Node.new("SplatVariable")
		popped = popUntilToken("*")
		node.token("star", popped.pop)
		node.node("variable", popped.pop)
		push(vars) unless @stack.last == vars
		push(node)
		popped.pop if popped.last == vars
		pushItems(popped)
		on_mlhs_add(vars, node)
	end

	def on_massign(vars, value)
		if vars.is_a?(Node)
			node = Node.new("Assignment")
			node.node("lhs", vars)
			node.node("value", value)
			popped = popUntilNode(vars)
			popped.pop
			node.token("assignment", popped.pop)
			popped.pop
			push(node)
			pushItems(popped)
			return node
		end
		node = Node.new("MultipleAssignment")
		node.node("variables", vars[0])
		node.token("commas", vars[1])
		node.node("value", value)
		popped = popUntilNode(vars)
		push(node)
		popped.pop
		node.token("assignment", popped.pop)
		popped.pop
		pushItems(popped)
		node
	end

	def on_break(value)
		node = Node.new("Break")
		if value[0].count > 0
			node.node("value", value[0][0])
		end
		popped = popUntilToken("break")
		node.token("break", popped.pop)
		if value[0].count > 0
			popped.pop
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_next(value)
		node = Node.new("Next")
		node.node("value", value[0][0])
		popped = popUntilToken("next")
		node.token("next", popped.pop)
		if value[0].count != 0
			popped.pop
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_command(command, args)
		node = Node.new("Call")
		node.token("name", command) 
		node.node("arguments", args[0])
		node.token("commas", args[1])
		popped = popUntilNode(command)
		push(node)
		popped.pop
		popped.pop
		pushItems(popped)
		node
	end

	def on_command_call(rcvr, period, name, args)
		node = Node.new("Call")
		node.node("receiver", rcvr)
		node.token("period", period)
		node.token("name", name) 
		if args.is_a?(Array)
			node.node("arguments", args[0])
			node.token("commas", args[1])
		end
		popped = popUntilNode(rcvr)
		popped.pop
		popped.pop
		popped.pop
		if args.is_a?(Array)
			popped.pop
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_until(condition, stmts)
		node = Node.new("Until")
		node.node("condition", condition)
		node.node("statements", stmts[0])
		node.token("commas", stmts[1])
		popped = popUntilToken("until")
		push(node)
		node.token("until", popped.pop)
		popped.pop
		if isTokenValue?(popped.last,"do")
			node.token("do", popped.pop)
		end
		popped.pop
		node.token("end", popped.pop)
		pushItems(popped)
		node
	end

	def on_symbol(name)
		node = Node.new("Symbol")
		node.token("name", name)
		popped = popUntilToken(":")
		node.token("colon", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_ifop(condition, thenValue, elseValue)
		node = Node.new("IfExpression")
		node.node("condition", condition)
		node.node("then", thenValue)
		node.node("else", elseValue)
		popped = popUntilNode(condition)
		popped.pop
		node.token("questionMark", popped.pop)
		popped.pop
		node.token("colon", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_string_embexpr(nodes)
		node = Node.new("InterpolatedExpression")
		popped = popUntilToken("\#{")
		node.token("left", popped.pop)
		begin
			if popped.count == 0
				raise "Stack is empty"
			end
			item = popped.pop
		end while !isTokenValue?(item, "}")
		node.token("right", item)
		push(node)
		pushItems(popped)
		node
	end

	def on_symbol_literal(sym)
		sym
	end

	def on_dot2(first, last)
		node = Node.new("Range")
		if first != nil
			popped = popUntilNode(first)
			node.node("from", popped.pop)
		else
			popped = popUntilToken("..")
		end
		node.token("dots", popped.pop)
		if last != nil
			node.node("to", popped.pop)
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_dot3(first, last)
		node = Node.new("ExcludeRange")
		if first != nil
			popped = popUntilNode(first)
			node.node("from", popped.pop)
		else
			popped = popUntilToken("...")
		end
		node.token("dots", popped.pop)
		if last != nil
			node.node("to", popped.pop)
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_while_mod(condition, stmt)
		node = Node.new("WhileModifier")
		node.node("condition", condition)
		node.node("statement", stmt)
		popped = popUntilNode(stmt)
		popped.pop
		node.token("while", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_for(var, range, stmts) 
		node = Node.new("For")
		node.node("variable", var)
		node.node("elements", range)
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("for")
		node.token("for", popped.pop)
		popped.pop
		node.token("in", popped.pop)
		popped.pop
		if isTokenValue?(popped.last, "do")
			node.token("do", popped.pop)
		end
		popped.pop
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_while(condition, stmts)
		node = Node.new("While")
		node.node("condition", condition)
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("while")
		node.token("while", popped.pop)
		popped.pop
		if isTokenValue?(popped.last, "do")
			node.token("do", popped.pop)
		end
		while isTokenValue?(popped.last, ";")
			stmts[1].push(popped.pop)
		end
		popped.pop
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_BEGIN(stmts)
		node = Node.new("Begin")
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("BEGIN")
		node.token("begin", popped.pop)
		node.token("left", popped.pop)
		popped.pop
		node.token("right",popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_END(stmts)
		node = Node.new("End")
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("END")
		node.token("end", popped.pop)
		node.token("left", popped.pop)
		popped.pop
		node.token("right",popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_begin(stmts)
		node = Node.new("BeginBlock")
		node.node("block", stmts)
		popped = popUntilToken("begin")
		node.token("begin", popped.pop)
		popped.pop
		item = popped.pop while !isTokenValue?(item,"end")
		node.token("end", item)
		push(node)
		pushItems(popped)
		node
	end

	def on_alias(newName, oldName)
		node = Node.new("Alias")
		node.token("newName", newName)
		node.token("oldName", oldName)
		popped = popUntilToken("alias")
		node.token("alias", popped.pop)
		popped.pop
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	alias_method :on_var_alias, :on_alias

	def on_ensure(stmts)
		node = Node.new("EnsureBlock")
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		popped = popUntilToken("ensure")
		node.token("ensure", popped.pop)
		popped.pop
		push(node)
		pushItems(popped)
		node
	end

	def on_retry()
		node = Node.new("Retry")
		node.token("retry", @stack.pop)
		push(node)
		node
	end

	def on_redo()
		node = Node.new("Redo")
		node.token("redo", @stack.pop)
		push(node)
		node
	end

	def on_void_stmt()
		node = Node.new("Void")
		semicolons = Array.new
		while isTokenValue?(@stack.last, ";")
			semicolons.unshift(@stack.pop)
		end
		if isTokenValue?(@stack.last, "end") || isTokenValue?(@stack.last, "ensure") || isTokenValue?(@stack.last, "rescue") || isTokenValue?(@stack.last, "}")
			item = @stack.pop
			push(node)
			push(item)
		else
			push(node)
		end
		pushItems(semicolons)
		node
	end

	def on_class(name, superClass, stmts)
		node = Node.new("Class")
		popped = popUntilToken("class")
		node.token("class", popped.pop)
		node.node("name", popped.pop)
		if superClass != nil
			node.token("lt", popped.pop)
			node.node("superclass", superClass)
			popped.pop
		end
		while isTokenValue?(popped.last, ";")
			stmts.addToken("semicolon", popped.pop)
		end
		node.node("body", stmts)
		popped.pop
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_rescue(type, var, stmts, nextHandler)
		node = Node.new("Rescue")
		popped = popUntilToken("rescue")
		push(node)
		node.token("rescue", popped.pop)
		if type != nil
			popped.pop
			if type.is_a?(Array)
				node.node("type", type[0])
			else
				node.node("type", type)
			end
		end
		if var != nil
			node.token("arrow", popped.pop)
			node.node("var", popped.pop)
		end
		node.node("statements", stmts[0])
		node.token("semicolons", stmts[1])
		if popped.last != stmts
			@stack.push(popped.pop)
		end
		popped.pop
		pushItems(popped)
		node
	end

	def on_mrhs_new_from_args(args)
		args
	end

	def on_mrhs_add(args, item)
		if args[0].count == 0
			node = item
		else
			node = Node.new("ValueList")
			node.node("values", args[0])
			node.addNode("values", item)
			node.token("commas", args[1])
		end
		popped = popUntilNode(args)
		push(node)
		popped.pop
		popped.pop
		pushItems(popped)
		node
	end

	def on_unary(unary, value)
		node = Node.new("Unary")
		count = 0
		popped = popUntil do |item| 
			count += 1
			item.is_a?(Token) && item.getValue().start_with?(unary.to_s()[0]) && count > 1
		end
		node.token("operator", popped.pop)
		if isTokenValue?(popped.last, "(")
			value.prependToken("leftParens", popped.pop)
			value = popped.pop
			value.addToken("rightParens", rParen = popped.pop)
		else
			value = popped.pop
		end
		node.node("value", value)
		push(node)
		pushItems(popped)
		node
	end

	def on_super(args)
		node = Node.new("SuperCall")
		popped = popUntilToken("super")
		node.token("superToken", popped.pop)
		node.node("arguments", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_zsuper()
		node = Node.new("SuperCall")
		popped = popUntilToken("super")
		node.token("superToken", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_yield(args)
		node = Node.new("Yield")
		popped = popUntilToken("yield")
		node.token("yield", popped.pop)
		if args.is_a?(Node)
			node.node("values", [args])
			popped.pop if popped.last == args
		else
			node.node("values", args[0])
			node.token("commas", popped.pop[1])
		end
		push(node)
		pushItems(popped)
		node
	end

	def on_yield0()
		node = Node.new("Yield")
		popped = popUntilToken("yield")
		node.token("yield", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_undef(args)
		node = Node.new("Undef")
		popped = popUntilToken("undef")
		node.token("undef", popped.pop)
		node.token("name", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_string_dvar(value)
		node = Node.new("DVarString")
		popped = popUntilNode(value)
		node.token("hash", @stack.pop)
		node.node("value", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_sclass(name, stmts)
		node = Node.new("SingletonClass")
		popped = popUntilToken("class")
		node.token("class", popped.pop)
		node.token("ltLt", popped.pop)
		node.node("name", popped.pop)
		while isTokenValue?(popped.last, ";")
			stmts.prependToken("semicolons", popped.pop)
		end
		node.node("block", popped.pop)
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_field(rcvr, dot, name)
		node = Node.new("Field")
		popped = popUntilNode(rcvr)
		node.node("receiver", popped.pop)
		node.token("period", popped.pop)
		node.token("name", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_string_concat(left, right) 
		node = Node.new("ConcatString")
		popped = popUntilNode(left)
		node.node("left", popped.pop)
		node.node("right", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_bare_assoc_hash(args)
		node = Node.new("AssociationArguments")
		popped = popUntilNode(args[0])
		node.node("args", args)
		commas = Array.new
		begin
			item = popped.pop
			if isTokenValue?(item, ",")
				commas.push(item)
			end
		end while item != args.last
		node.token("commas", commas)
		push(node)
		pushItems(popped)
		node
	end

	def on_assoc_splat(arg)
		node = Node.new("AssocSplatArgument")
		popped = popUntilToken("**")
		node.token("splat", popped.pop)
		node.node("argument", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_args_forward()
		node = Node.new("ArgsForward")
		popped = popUntilToken("...")
		node.token("dots", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_module(name, statements)
		node = Node.new("Module")
		popped = popUntilToken("module")
		node.token("module", popped.pop)
		node.node("name", popped.pop)
		node.node("block", statements)
		popped.pop
		node.token("end", popped.pop)
		push(node)
		pushItems(popped)
		node
	end

	def on_arg_ambiguous(token)
		true
	end

	def on_operator_ambiguous(op, str)
		true
	end

	def on_magic_comment(name, value)
	end

	def on_int(s)
		node = Node.new("Number")
		node.token("value", Token.new(lineno(), column(), s))
		push(node)
		node
	end

	alias_method :on_imaginary, :on_int
	alias_method :on_float, :on_int
	alias_method :on_rational, :on_int

	def on_CHAR(s)
		node = Node.new("Character")
		node.token("value", Token.new(lineno(), column(), s))
		push(node)
		node
	end

	def on_label(s)
		node = Node.new("Label")
		node.token("value", Token.new(lineno(), column(), s))
		push(node)
		node
	end

	def on_comment(s)
		token = Token.new(lineno(), column(), s)
		@comments.push(token)
		token
	end

	def on___end__(s)
		token = Token.new(lineno(), column(), s)
		@endToken = token
		token
	end

	def ignoreToken(s)
	end

	alias_method :on_sp, :ignoreToken
	alias_method :on_nl, :ignoreToken
	alias_method :on_ignored_nl, :ignoreToken
	alias_method :on_ignored_sp, :ignoreToken
	alias_method :on_words_sep, :ignoreToken

	def createToken(s)
		token = Token.new(lineno(), column(), s)
		push(token)
		token
	end

	def on_rbrace(s)
		token = Token.new(lineno(), column(), s)
		if isNodeOfType?(@stack.last, "Hash") && @stack.last.getToken("right") == nil
			@stack.last.token("right", token)
		else
			push(token)
		end
		token
	end

	alias_method :on_semicolon, :createToken
	alias_method :on_ident, :createToken
	alias_method :on_op, :createToken
	alias_method :on_kw, :createToken
	alias_method :on_lparen, :createToken
	alias_method :on_rparen, :createToken
	alias_method :on_lbracket, :createToken
	alias_method :on_rbracket, :createToken
	alias_method :on_lbrace, :createToken
	alias_method :on_comma, :createToken
	alias_method :on_tstring_beg, :createToken
	alias_method :on_tstring_end, :createToken
	alias_method :on_qsymbols_beg, :createToken
	alias_method :on_qsymbols_end, :createToken
	alias_method :on_symbols_beg, :createToken
	alias_method :on_symbols_end, :createToken
	alias_method :on_tstring_content, :createToken
	alias_method :on_period, :createToken
	alias_method :on_cvar, :createToken
	alias_method :on_gvar, :createToken
	alias_method :on_ivar, :createToken
	alias_method :on_const, :createToken
	alias_method :on_regexp_beg, :createToken
	alias_method :on_regexp_end, :createToken
	alias_method :on_symbeg, :createToken
	alias_method :on_embexpr_beg, :createToken
	alias_method :on_embexpr_end, :createToken
	alias_method :on_heredoc_beg, :createToken
	alias_method :on_heredoc_end, :createToken
	alias_method :on_words_beg, :createToken
	alias_method :on_qwords_beg, :createToken
	alias_method :on_qwords_end, :createToken
	alias_method :on_tlambda, :createToken
	alias_method :on_tlambeg, :createToken
	alias_method :on_backtick, :createToken
	alias_method :on_backref, :createToken
	alias_method :on_embvar, :createToken
	alias_method :on_label_end, :createToken

	def on_embdoc_beg(s)
		@embeddedDoc.push(Token.new(lineno(), column(), s))
	end
	alias_method :on_embdoc, :on_embdoc_beg
	alias_method :on_embdoc_end, :on_embdoc_beg

end
