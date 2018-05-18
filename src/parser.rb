require_relative "./identifier_token.rb"
require_relative "./literal_token.rb"

class ASTNode
  attr_reader :children

  def initialize(children)
    @children = children
  end

  def execute
    raise "Not implemented"
  end
end

# rude node
# parenthesis (one arg or till end of parenthesis)
# override execute in each node to do a thing

class RootNode < ASTNode
  def to_s
    puts children
  end
end

class FunctionCallNode < ASTNode
  def to_s
    "FunctionCall(#{@children}, args: [#{children}])"
  end
end

class AssignmentNode < ASTNode
  def to_s
    "Assignment(#{@children}, #{@children})"
  end
end

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
