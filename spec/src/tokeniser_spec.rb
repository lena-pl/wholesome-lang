require 'spec_helper'

describe Tokeniser do
  let(:program) do
    <<~EOS
      psst "Hello, from Wholesomelang"
    EOS
  end

  subject { Tokeniser.new(program, dictionary) }

  let(:dictionary) { [] }
  let(:parse_result) { subject.call }

  RSpec.shared_examples "the happy case" do
    it "successfully tokenises the program" do
      expected_result = [IdentifierToken.new("psst"), LiteralToken.new("Hello, from Wholesomelang")]

      expect(parse_result.map(&:class)).to eq expected_result.map(&:class)
      expect(parse_result.map(&:value)).to eq expected_result.map(&:value)
    end
  end

  context "with an empty dictionary" do
    it_behaves_like "the happy case"
  end

  context "with a populated dictionary" do
    let(:rude_word) { 'impolite' }

    before { dictionary << rude_word }

    context "with polite source code" do
      it_behaves_like "the happy case"
    end

    context "with a rude word in the source code" do
      let(:program) do
        <<~EOS
          psst #{rude_word}
        EOS
      end

      it "raises a critical rude" do
        expect{ parse_result }.to raise_error(RuntimeError, /CRITICAL RUDE/)
      end
    end
  end
end
