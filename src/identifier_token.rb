class IdentiferToken < Token
  def initialize(value)
    @val = value
  end

  def print
    "Identifier(#{@val})"
  end
end
