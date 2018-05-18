require_relative "./ast_base.rb"

class FunctionCallNode < ASTBase
	def debug_print(level)
		identifier = children_of_type(IdentifierToken).first
		arguments = @children - [identifier]


		pad = ("\t" * level)
		"#{pad}FunctionCall\n#{identifier.debug_print(level+1)}"
	end
end
