class ASTBase
  attr_reader :children

  def initialize(children)
    @children = children
  end

<<<<<<< Updated upstream
  def debug_print
    raise 'Not implemented'
  end

  def execute(context)
    raise 'Not implemented'
  end

  def children_of_type(type)
    @children.select { |c| c.class == type }
=======
  def execute(context)
    raise "Not implemented"
>>>>>>> Stashed changes
  end
end
