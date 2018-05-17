require_relative "./identifier_token.rb"
require_relative "./literal_token.rb" 

class ASTNode
end

class FunctionCallNode < ASTNode
  def initialize(identifier, parameters = [])
    @identifier = identifier
    @parameters = parameters
  end

  def to_s
    parameters = @parameters.map(&:print).join(",")
    "FunctionCall(#{@identifier}, args: [#{parameters}])"
  end
end

class AssignmentNode < ASTNode
  def initialize(identifier, val) 
    @identifier = identifier
    @val = val
  end

  def to_s
    "Assignment(#{@identifier}, #{@val})"
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
      # puts st.print
      @ast << st
    end

    @ast
  end

  def parse_statement
    if identifier = accept(IdentifierToken)
      if accept(AssignmentToken)
        return AssignmentNode.new(identifier, parse_expression)
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
  	FunctionCallNode.new(identifier)
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
