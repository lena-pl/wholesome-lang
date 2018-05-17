class Token
end

class LiteralToken < Token
  def initialize(value)
    @val = value
  end

  def print
    "Literal(#{@val})"
  end
end

class IdentiferToken < Token
  def initialize(value)
    @val = value
  end

  def print
    "Identifier(#{@val})"
  end
end

class TokeniserService
  attr_reader :chars

  SEPERATORS = [" ", nil, "\n"]
  LITERAL_SIGNIFIER = '"'

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

    puts @tokens.map(&:print).join("\n")
  end

  def identify_token(w)
    if /\".*\"/.match(w)
      return LiteralToken.new(w)
    elsif /.*/.match(w)
      return IdentiferToken.new(w)
    end
  end
end

class ParserService
  def initialize(tokens)
    @tokens = tokens
  end

  def call
  end
end

program = <<~EOS
  psst "Hello, from Wholesomelang"
EOS

tokens = TokeniserService.new(program).call
ast = ParserService.new(tokens).call
