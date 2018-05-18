class LiteralToken < Token
  EXPRESSION = /\"(.*)\"/

  def initialize(value)
    @value = value
  end

  def to_s
    "Literal(#{value})"
  end

  def self.from(token_match)
    new(token_match[1])
  end
end
