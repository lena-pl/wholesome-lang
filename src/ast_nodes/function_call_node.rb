require_relative "./ast_base.rb"

class FunctionCallNode < ASTBase
  def to_s
    "FunctionCall(#{@children}, args: [#{children}])"
  end
end
