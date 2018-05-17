require_relative "../wholesome-lang.rb"

class IdentifierToken < Token
  EXPRESSION = /.*/

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print
    "Identifier(#{value})"
  end

  def self.from(token_match)
    new(token_match[0])
  end
end
