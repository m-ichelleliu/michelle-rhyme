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

    it 'random rhyme all starts with starting string' do
        lines = rhyme.rhyme_random.split("\n")
        lines.each do |line|
          expect(line.start_with?(rhyme.start_string)).to eq(true)
        end
    end
    
    it 'ends each line with the previous line (minus starting string)' do
      lines = rhyme.rhyme_random.split("\n")
      prev_line = ""
      lines.each do |line|
          line = line.delete_prefix(rhyme.start_string)
          expect(line.end_with?(prev_line)).to eq(true)
          prev_line = line
        end
    end
end
