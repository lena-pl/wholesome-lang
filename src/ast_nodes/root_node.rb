require_relative "./ast_base.rb"

class RootNode < ASTBase
	def debug_print(level)
		children = @children.map { |c| c.debug_print(level+1) }
		"#{'\t' * level}RootNode\n#{children.join("\n")}"
	end
end
