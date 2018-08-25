require "./src/token"
require "./src/identifier_token"
require "./src/literal_token"
require "./src/assignment_token"
require "./src/parser"
require "./src/tokeniser"
require "./src/context"
require 'byebug'

DICTIONARY_FOLDER = "List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words"
DICTIONARY_FILE = File.join(__dir__, DICTIONARY_FOLDER, "dictionary.txt")

if File.file?(DICTIONARY_FILE)
	dictionary = File.read(DICTIONARY_FILE)
else
	unless File.directory?(DICTIONARY_FOLDER)
		%x(git clone git@github.com:LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words.git)
	end

	%x(cd #{DICTIONARY_FOLDER})
	%x(git pull)

	ignored_files = ["README.md", "USERS.md", "LICENSE", ".", "..", ".git"]
	files = Dir.entries(DICTIONARY_FOLDER) - ignored_files
	%x(cat #{files.map{|file|  File.join(__dir__, DICTIONARY_FOLDER, file)}.join(" ")} | sort > #{DICTIONARY_FILE})
	%x(cd ..)

	dictionary = File.read(DICTIONARY_FILE)
end

filename = ARGV.last
source = File.open(filename).read

if ARGV.include?("--dump-source") || ARGV.include?("-s")
	puts "Source:"
	puts source
	puts
end

tokens = Tokeniser.new(source, dictionary.split("\n")).call

if ARGV.include?("--dump-tokens") || ARGV.include?("-t")
	puts "Token stream:"
  puts tokens.map(&:to_s).join("\n")
  puts
end

tree = Parser.new(tokens).call

if ARGV.include?("--dump-tree") || ARGV.include?("-d")
	puts "AST:"
  puts tree.debug_print(0)
  puts
end

context = Context.new
tree.execute(context)

if ARGV.include?("--dump-context") || ARGV.include?("-c")
	puts "Context:"
  puts context.variables
  puts
end
