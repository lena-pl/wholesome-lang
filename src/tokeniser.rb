class Tokeniser
  attr_reader :chars

  SEPERATORS = [" ", nil, "\n"]
  LITERAL_SIGNIFIER = '"'
  ASSIGNMENT = "="

  TOKENS = [
    AssignmentToken,
    LiteralToken,
    IdentifierToken,
  ]

  def initialize(source)
    @source = source
    @chars = source.chars
    @tokens = []
  end

  def call
    current_token = ""

    in_a_literal = false

    @chars.length.times do
      current_letter = chars.shift

      if current_letter == LITERAL_SIGNIFIER
        in_a_literal = !in_a_literal
      end

      if in_a_literal
      elsif SEPERATORS.include?(current_letter)
        @tokens << identify_token(current_token)

        current_token = ""
        current_letter = ""
      end

      current_token += current_letter if current_letter
    end

    @tokens
  end

  def identify_token(unknown_token)
    TOKENS.reduce(nil) do |parsed_token, token_class|
      return parsed_token unless parsed_token.nil?

      match = token_class.const_get("EXPRESSION").match(unknown_token)
      token_class.from(match) if match
    end
  end
end
