class IdentifierToken < Token
  EXPRESSION = /.*/

  def initialize(value)
    @value = value
  end

  def to_s
    "Identifier(#{value})"
  end

  def self.from(token_match)
    new(token_match[0])
  end
end
