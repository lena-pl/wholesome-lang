require_relative "./identifier_token.rb"
require_relative "./literal_token.rb"
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
    FunctionCallNode.new([identifier])
  end

  def accept(token)
    current_peek = @tokens[@current]
    @current += 1

    if current_peek.class == token
      current_peek
    else
      nil
    end
  end

  def expect(token)
    current_peek = accept(token)

    return current_peek if current_peek

    raise "Expected #{token} got #{current_peek.class}"
  end
end
