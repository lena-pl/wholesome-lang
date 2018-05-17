class AssignmentToken < Token
  EXPRESSION = /=/

  def to_s
    "Assignment"
  end

  def self.from(token_match)
    new
  end
end
