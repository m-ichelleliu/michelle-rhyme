require 'spec_helper'
require_relative '../rhyme.rb'

describe Rhyme do
    it 'returns the rhyme string' do
        rhyme = Rhyme.new
        answer = File.open('jack.txt').read
        expect(rhyme.to_s).to eq(answer)
    end
end
