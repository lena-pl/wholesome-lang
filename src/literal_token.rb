class LiteralToken < Token
  def initialize(value)
    @val = value
  end

  def print
    "Literal(#{@val})"
  end
end
