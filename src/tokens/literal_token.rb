# frozen_string_literal: true

class LiteralToken < Token
  EXPRESSION = /\"(.*)\"/

  def initialize(value)
    @value = value
  end

  def to_s
    "Literal(#{value})"
  end

  def debug_print(level)
    pad = "\t" * level
    "#{pad}#{to_s}"
  end

  def self.from(token_match)
    new(token_match[1])
  end
end
