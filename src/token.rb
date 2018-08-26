# frozen_string_literal: true

class Token
  def value
    @value
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
