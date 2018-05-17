require "./src/token"
require "./src/identifier_token"
require "./src/literal_token"
require "./src/parser"
require "./src/tokeniser"

example_program = <<~EOS
  psst "Hello, from Wholesomelang"
EOS

tokens  = Tokeniser.new(example_program).call
tree    = Parser.new(tokens).call

if ARGV.include?("--dump-tokens") || ARGV.include?("-t")
  puts tokens
end

if ARGV.include?("--dump-tree") || ARGV.include?("-d")
  puts tree
end
