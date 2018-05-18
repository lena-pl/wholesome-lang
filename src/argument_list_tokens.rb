class StartArgumentListToken < Token
  EXPRESSION = /\(/

  def to_s
    "StartArgumentList"
  end

  # def debug_print(level)
  #   pad = "\t" * level
  #   "#{pad}#{to_s}"
  # end

  def self.from(token_match)
    new
  end
end
