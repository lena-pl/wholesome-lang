require_relative "./identifier_token.rb"
require_relative "./literal_token.rb"
require_relative "./argument_list_tokens.rb"
require_relative "./argument_list_tokens.rb"
require_relative "./ast_nodes/assignment_node.rb"
require_relative "./ast_nodes/function_call_node.rb"
require_relative "./ast_nodes/root_node.rb"

class Parser
  def initialize(tokens)
    @tokens = tokens
    @current = 0
    @ast = []
  end

  def call
    parse_program
  end

  private

  def parse_program
    while @current < @tokens.length
      st = parse_statement
      @ast << st
    end

    RootNode.new(@ast)
  end

  def parse_statement
    if identifier = accept(IdentifierToken)
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
