class ASTBase
  attr_reader :children

  def initialize(children)
    @children = children
  end

  def execute
    raise "Not implemented"
  end
end
