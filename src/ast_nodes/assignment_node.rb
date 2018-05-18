require_relative "./ast_base.rb"

class AssignmentNode < ASTBase
  def to_s
    "Assignment(#{@children}, #{@children})"
  end
end
