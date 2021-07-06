require "./rast-st.rb"

if ARGV.count == 0
	filename = '.'
else
	filename = ARGV[0]
end

Dir.glob(filename + '/**/*.rb') do |fn|
	File.open(fn + '.ast', 'w') { |file| file.write(SmalltalkASTWriter.new(fn).generateLiteralArray) }
end