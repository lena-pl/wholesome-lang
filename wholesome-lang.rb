require "./src/token"
require "./src/identifier_token"
require "./src/literal_token"
require "./src/assignment_token"
require "./src/parser"
require "./src/tokeniser"
require "./src/context"

example_program = <<~EOS
  greeting_from = "Wholesomelang"
  psst "Hello, from {{greeting_from}}"
EOS

tokens  = Tokeniser.new(example_program).call
tree    = Parser.new(tokens).call

if ARGV.include?("--dump-source") || ARGV.include?("-s")
	puts "Source:"
	puts example_program
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
  context = Context.new
  tree.execute(context)
  puts context.content
  puts
end
