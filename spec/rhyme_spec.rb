require 'spec_helper'
require_relative '../rhyme.rb'

describe Rhyme do
    rhyme = Rhyme.new
    answer = File.read('jack.txt')

    describe '#easy_print' do
        it 'returns the rhyme string' do
            expect(rhyme.rhyme_easy).to eq(answer)
        end
    end

    describe '#hard_print' do
        it 'returns the rhyme string' do
            expect(rhyme.rhyme_hard).to eq(answer)
        end
    end

    describe '#random_print' do
        it 'all starts with the starting string' do
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

        # Phrases match suffixes, and each used once
    end    
end
