require_relative "./ast_base.rb"

class FunctionCallNode < ASTBase
  def debug_print(level)
		identifier = children_of_type(IdentifierToken).first
		arguments = @children - [identifier]
		arguments_string = arguments.map { |a| a.debug_print(level+1) }.join("\n")


		pad = ("\t" * level)
		"#{pad}FunctionCall\n#{identifier.debug_print(level+1)}\n#{arguments_string}"
	end

  def to_s
    "FunctionCall(#{@children}, args: [#{children}])"
  end

  def execute(context)
  	identifier = children_of_type(IdentifierToken).first
  	arguments = @children - [identifier]

    function = context.find_function(identifier.value)
    raise "Unknown function `#{identifier.value}` called - aw heck" unless function

    if function.respond_to?(:call)
    	function.call(context, arguments.map(&:value))
    else
    	raise "We don't have wholelang functions yet"
    end

  end
end
