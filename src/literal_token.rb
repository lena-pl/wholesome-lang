require_relative "token"

class LiteralToken < Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print
    "Literal(#{value})"
  end
end
