# frozen_string_literal: true

require 'byebug'

class Tokeniser
  attr_reader :chars

  SEPERATORS = [' ', nil, "\n"].freeze
  LITERAL_SIGNIFIER = '"'.freeze
  ASSIGNMENT = '='.freeze

  def initialize(source, dictionary)
    @source = source.strip.chomp
    @dictionary = dictionary
    @chars = @source.chars
    @tokens = []
  end

  def call
    current_token = ''

    in_a_literal = false

    @chars.length.times do
      current_letter = chars.shift

      in_a_literal = !in_a_literal if current_letter == LITERAL_SIGNIFIER

      if in_a_literal
      elsif SEPERATORS.include?(current_letter)
        @tokens << identify_token(current_token)

        current_token = ''
        current_letter = ''
      end

      current_token += current_letter if current_letter
    end

    @tokens << identify_token(current_token)

    @tokens
  end

  def identify_token(unknown_token)
    unknown_token.split.each do |word|
      if @dictionary.include?(word.downcase.tr('\"', '').tr('.','').tr(',','').tr('}','').tr('{',''))
        raise 'CRITICAL RUDE: source code not wholesome'
      end
    end

    Token.descendants.reduce(nil) do |parsed_token, token_class|
      return parsed_token unless parsed_token.nil?

      match = token_class.const_get("EXPRESSION").match(unknown_token)
      token_class.from(match) if match
    end
  end
end
