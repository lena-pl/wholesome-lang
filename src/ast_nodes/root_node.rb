require_relative "./ast_base.rb"

class RootNode < ASTBase
  def debug_print(level)
    children = @children.map { |c| c.debug_print(level+1) }
    "#{'\t' * level}RootNode\n#{children.join("\n")}"
  end

  def to_s
    puts children
  end

  def execute(context)
    children.each { |child| child.execute(context) }
  end
end
