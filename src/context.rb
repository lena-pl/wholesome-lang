# frozen_string_literal: true

require_relative './native_functions.rb'

class Context
  include NativeFunctions
  attr_reader :variables

  def initialize(filename)
    @filename = filename
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

  attr_reader :filename

  def setup_hacks
    add_native_functions_to_scope
  end
end
