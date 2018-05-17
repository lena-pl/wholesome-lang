class ASTNode
end

class FunctionCallNode < ASTNode
  def initialize(identifier, parameters = [])
    @identifier = identifier
    @paramters = parameters
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
  	@ast << parse_statement
  end

  def parse_statement
  	parse_call
  end

  def parse_call
  	token = expect(IdentifierToken)

  	FunctionCallNode.new(token.value)
  end

  def expect(token)
  	current_peek = @tokens[@current]
  	@current += 1

  	return current_peek if current_peek.class == token
  	return nil
  end
end
