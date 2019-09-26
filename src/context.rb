# frozen_string_literal: true

class Context
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
    define_native_function('psst') do |context, parameters|
      output = parameters.map do |p|
        variable = p.match(/{{(.*)}}/) {|m| m[1]}

        variable ? p.gsub(/{{.*}}/, context.fetch_variable(variable)) : p
      end

      puts output
    end

    define_native_function('yikes') do |context, parameters|
      puts "Yikes! #{parameters[0]}"
      puts "Hecked up in:"
      puts "#{filename}"
      exit!
    end
  end
end
