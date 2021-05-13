require "./rast.rb"

class SmalltalkASTWriter

	def initialize(filename)
		@source = File.read(filename)
		@result = ""
		@lines = Array.new
		@lines.push(1)
		@lines.push(1)
		for i in 0..@source.length
			if @source[i] == "\n" || (@source[i] == "\r" && @source[i+1] != "\n")
				@lines.push(i + 2)
			end
		end
	end

	def generateLiteralArray()
		parser = ASTBuilder.new(@source)
		ast = parser.parse
		output(ast)
		@result
	end

	def outputNode(node)
		if node.getNodeType == "Void"
			return
		end
		@result << "#("
		@result << node.getNodeType
		@result << " "
		node.getNodeNames.each do |each|
			value = node.getNode(each)
			if (value.is_a?(Array) && value.count == 0) || value == nil
				next
			end
			@result << each
			@result << " "
			output(value)
			@result << " "
		end
		node.getTokenNames.each do |each|
			value = node.getToken(each)
			if (value.is_a?(Array) && value.count == 0) || value == nil
				next
			end
			if each == "comments"
				@result << "comments #("
				value.each do |each|
					@result << (@lines[each.getLine] + each.getColumn).to_s
					@result << " "
					@result << (@lines[each.getLine] + each.getColumn + each.getValue.length - 1).to_s
					@result << " "
				end
				@result << ")"
			else
				@result << each
				@result << " "
				output(value)
				@result << " "
			end
		end
		@result << ")"
	end

	def outputToken(token)
		@result << "#('"
		token.getValue.each_char do |each|
			if each == "'"
				@result << "''"
			else
				@result << each
			end
		end
		@result << "' "
		@result << (@lines[token.getLine] + token.getColumn).to_s
		@result << ")"
	end

	def outputArray(array)
		@result << "#("
		array.each do |each| 
			output(each)
			@result << " "
		end
		@result << ")"
	end

	def output(obj)
		outputNode(obj) if obj.is_a?(Node)
		outputToken(obj) if obj.is_a?(Token)
		outputArray(obj) if obj.is_a?(Array)
	end

end
