require 'spec_helper'

describe Tokeniser do
  let(:program) do
    <<~EOS
      psst "Hello, from Wholesomelang"
    EOS
  end

  subject { Tokeniser.new(program) }
  let(:parse_result) { subject.call }

  it "successfully tokenises the program" do
    expected_result = [IdentifierToken.new("psst"), LiteralToken.new("\"Hello, from Wholesomelang\"")]

    expect(parse_result.map(&:class)).to eq expected_result.map(&:class)
    expect(parse_result.map(&:value)).to eq expected_result.map(&:value)
  end
end
