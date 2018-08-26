# frozen_string_literal: true

class Context
  attr_reader :variables

  def initialize
    @variables = {}
    @functions = {}

    setup_hacks
  end

  def set_variable(name, value)
    @variables[name.to_sym] = value
  end

  def fetch_variable(name)
    @variables[name.to_sym]
  end

  def find_function(name)
    @functions[name]
  end

  def define_function(name, root_node)
  end

  def define_native_function(name, &block)
    @functions[name] = block
  end

  private

  def setup_hacks
    define_native_function('psst') do |context, parameters|
      output = parameters.map do |p|
        variable = p.match(/{{(.*)}}/)[1]
        p.gsub(/{{.*}}/, context.fetch_variable(variable))
      end

      puts output
    end
  end
end
