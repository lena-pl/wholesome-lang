# frozen_string_literal: true

module NativeFunctions
  def add_native_functions_to_scope
    add_psst
    add_yikes
  end

  private

  def add_psst
    define_native_function('psst') do |context, parameters|
      output = parameters.map do |p|
        variable = p.match(/{{(.*)}}/) {|m| m[1]}

        variable ? p.gsub(/{{.*}}/, context.fetch_variable(variable)) : p
      end

      puts output
    end
  end

  def add_yikes
    define_native_function('yikes') do |context, parameters|
      puts "Yikes! #{parameters[0]}"
      puts "Hecked up in:"
      puts "#{filename}"
      exit!
    end
  end
end