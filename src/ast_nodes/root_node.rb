require_relative "./ast_base.rb"

class RootNode < ASTBase
  def to_s
    puts children
  end
end
