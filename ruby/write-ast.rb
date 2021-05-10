require "./rast-st.rb"

if ARGV.count == 0
	filename = __FILE__
else
	filename = ARGV[0]
end

print SmalltalkASTWriter.new(filename).generateLiteralArray