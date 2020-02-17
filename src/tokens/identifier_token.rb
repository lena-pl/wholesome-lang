# frozen_string_literal: true

class IdentifierToken < Token
  EXPRESSION = /[^="].*[^"]$/

  def initialize(value)
    @value = value
  end

  def to_s
    "Identifier(#{value})"
  end

  def debug_print(level)
    pad = "\t" * level
    "#{pad}#{to_s}"
  end

  def self.from(token_match)
    new(token_match[0])
  end
end
