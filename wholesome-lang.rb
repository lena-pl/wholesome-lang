require "./src/token"
require "./src/identifier_token"
require "./src/literal_token"
require "./src/assignment_token"
require "./src/parser"
require "./src/tokeniser"
require "./src/context"

filename = ARGV.last
source = File.open(filename).read

tokens  = Tokeniser.new(source).call
tree    = Parser.new(tokens).call
context = Context.new

tree.execute(context)

if ARGV.include?("--dump-source") || ARGV.include?("-s")
	puts "Source:"
	puts source
	puts
end

if ARGV.include?("--dump-tokens") || ARGV.include?("-t")
	puts "Token stream:"
  puts tokens.map(&:to_s).join("\n")
  puts
end

if ARGV.include?("--dump-tree") || ARGV.include?("-d")
	puts "AST:"
  puts tree.debug_print(0)
  puts
end

if ARGV.include?("--dump-context") || ARGV.include?("-c")
	puts "Context:"
  puts context.variables
  puts
end
