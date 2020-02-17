# frozen_string_literal: true
$LOAD_PATH << './src/ast_nodes'

# tokens
require 'token'
require 'identifier_token'
require 'literal_token'
require 'assignment_token'
require 'start_argument_list_token'

# ast nodes
require 'assignment_node'
require 'function_call_node'
require 'root_node'

class Parser
  attr_reader :loud

  def initialize(tokens, loud: false)
    @tokens = tokens
    @current = 0
    @ast = []
    @loud = loud
  end

  def call
    parse_program
  end

  private

  def parse_program
    if loud
      puts "TOKENS:"
      puts @tokens
      puts "==============="
    end

    while @current < @tokens.length
      st = parse_statement
      @ast << st
    end

    RootNode.new(@ast)
  end

  def parse_statement
    identifier = accept(IdentifierToken)

    if identifier
      if accept(AssignmentToken)
        return AssignmentNode.new([identifier, parse_expression])
      else
        return parse_call(identifier)
      end
    else
      raise "Syntax error, unexpected: #{@tokens[@current]}"
    end
  end

  def parse_expression
    expect(LiteralToken)
  end

  def parse_call(identifier)
    arguments = []

    if accept(StartArgumentListToken)
      while next_argument != accept(LiteralToken)
        arguments << next_argument
      end
    else
      arguments = [expect(LiteralToken)]
    end

    FunctionCallNode.new([identifier] + arguments)
  end

  def accept(token)
    current_peek = @tokens[@current]

    if loud
      puts "current_peek = " + current_peek.to_s
      puts "token = " + token.to_s
      puts "---"
    end

    if current_peek.class == token
      @current += 1
      current_peek
    else
      nil
    end
  end

  def expect(token)
    current_peek = accept(token)

    return current_peek if current_peek

    raise "Expected #{token} got #{current_peek.class}, previous was: #{@tokens[@current-1].class}"
  end
end
