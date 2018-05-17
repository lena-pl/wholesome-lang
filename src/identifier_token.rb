require_relative "../wholesome-lang.rb"

class IdentifierToken < Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print
    "Identifier(#{value})"
  end
end
