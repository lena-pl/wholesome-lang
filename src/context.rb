class Context
  attr_reader :content

  def initialize
    @content = {}
  end

  def set_variable(name, value)
    @content[name.to_sym] = value
  end
end
