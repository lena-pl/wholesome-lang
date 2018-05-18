require_relative "./ast_base.rb"

class AssignmentNode < ASTBase
  def debug_print(level)
    identifier = children_of_type(IdentifierToken).first
		expression = @children - [identifier]
		expression_string = expression.map { |a| a.debug_print(level+1) }.join("\n")

		pad = ("\t" * level)
		"#{pad}Assignment\n#{identifier.debug_print(level+1)}\n#{expression_string}\n"
  end
end
