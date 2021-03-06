require './components'

require 'byebug'
require 'optparse'

DICTIONARY_FOLDER = 'List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words'.freeze
DICTIONARY_FILE = File.join(__dir__, DICTIONARY_FOLDER, 'dictionary.txt').freeze

if ARGV.include?('--help')
  puts <<~EOS
  usage: ruby wholesome-lang.rb [flags] <filename>

  Here are the current wholesome-lang.rb flags:

  debugging
     --failure-rate      Execute the wl file 100 times, logging the parsing process each time; reports pass/fails stats
     --dump-source       Print the source code after executing the wl file
     --dump-tokens       Print the tokens stream before executing the wl file
     --dump-tree         Step through every node via parser, calling debug_print before executing the wl file
     --dump-context      Print the variables from source after executing the wl file
  EOS
else
  filename = ARGV.last

  if filename.nil? || filename.strip.empty?
    raise 'No .wl file provided for execution'
  end

  unless File.file?(DICTIONARY_FILE)
    unless File.directory?(DICTIONARY_FOLDER)
    `git clone git@github.com:LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words.git`
    end

    `cd #{DICTIONARY_FOLDER}`
    `git pull`

    ignored_files = ['README.md', 'USERS.md', 'LICENSE', '.', '..', '.git']
    files = Dir.entries(DICTIONARY_FOLDER) - ignored_files
    `cat #{files.map{|file| File.join(__dir__, DICTIONARY_FOLDER, file)}.join(' ')} | sort > #{DICTIONARY_FILE}`
    `cd ..`
  end

  dictionary = File.read(DICTIONARY_FILE)

  source = File.open(filename).read

  if ARGV.include?('--failure-rate')
    passes = 0
    failures = 0

    100.times do
      error = nil

      begin
        context = Context.new
        tokens = Tokeniser.new(source, dictionary.split("\n")).call
        tree = Parser.new(tokens, :loud => true).call
        tree.execute(context)
      rescue Exception => e
        error = e
      end
      puts e if e

      error.nil? ? passes+=1 : failures+=1
    end

    puts "Passes: #{passes}"
    puts "Failures: #{failures}"
  else
    if ARGV.include?('--dump-source') || ARGV.include?('-s')
      puts 'Source:'
      puts source
      puts
    end

    tokens = Tokeniser.new(source, dictionary.split("\n")).call

    if ARGV.include?('--dump-tokens') || ARGV.include?('-t')
      puts 'Token stream:'
      puts tokens.map(&:to_s).join("\n")
      puts
    end

    tree = Parser.new(tokens).call

    if ARGV.include?('--dump-tree') || ARGV.include?('-d')
      puts 'AST:'
      puts tree.debug_print(0)
      puts
    end

    context = Context.new
    tree.execute(context)

    if ARGV.include?('--dump-context') || ARGV.include?('-c')
      puts 'Context:'
      puts context.variables
      puts
    end
  end
end
