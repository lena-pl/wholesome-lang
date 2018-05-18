require_relative "./ast_base.rb"

class AssignmentNode < ASTBase
  attr_reader :identifier, :literal

  def debug_print(level)
    identifier = children_of_type(IdentifierToken).first
    expression = @children - [identifier]
    expression_string = expression.map { |a| a.debug_print(level+1) }.join("\n")

    pad = ("\t" * level)
    "#{pad}Assignment\n#{identifier.debug_print(level+1)}\n#{expression_string}\n"
  end

  def to_s
    "Assignment(#{@children}, #{@children})"
  end

  def execute(context)
    children.each do |child|
      if child.class == IdentifierToken
        @identifier = child.value
      elsif child.class == LiteralToken
        @literal = child.value
      end
    end

    context.set_variable(@identifier, @literal)
  end
end
