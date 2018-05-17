require_relative "../wholesome-lang.rb"

class LiteralToken < Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print
    "Literal(#{value})"
  end
end
