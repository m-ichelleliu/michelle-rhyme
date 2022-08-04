require 'spec_helper'
require_relative '../rhyme.rb'

describe Rhyme do
    rhyme = Rhyme.new
    answer = File.read('jack.txt')

    it 'easy print returns the rhyme string' do
        expect(rhyme.rhyme_easy).to eq(answer)
    end

    it 'hard print returns the rhyme string' do
        expect(rhyme.rhyme_hard).to eq(answer)
    end
end
