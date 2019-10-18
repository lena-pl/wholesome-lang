# frozen_string_literal: true

require_relative './ast_base.rb'

class FunctionCallNode < ASTBase
  def debug_print(level)
    identifier = children_of_type(IdentifierToken).first
    arguments = @children - [identifier]
    arguments_string = arguments.map { |a| a.debug_print(level + 1) }.join("\n")

    pad = ("\t" * level)
    "#{pad}FunctionCall\n#{identifier.debug_print(level+1)}\n#{arguments_string}"
  end

  def to_s
    "FunctionCall(#{@children}, args: [#{children}])"
  end

  def execute(context)
<<<<<<< Updated upstream
    identifier = children_of_type(IdentifierToken).first
    arguments = @children - [identifier]

    function = context.find_function(identifier.value)
    raise "Unknown function `#{identifier.value}` called - aw heck" unless function

    raise "We don't have wholesomelang functions yet" unless function.respond_to?(:call)

    function.call(context, arguments.map(&:value))
=======
    puts "¯\_(ツ)_/¯"
>>>>>>> Stashed changes
  end
end
