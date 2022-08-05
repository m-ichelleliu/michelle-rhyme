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
        it 'uses each phrase from the suffixes.txt file exactly once' do
            suffixes = File.read("suffixes.txt").split("\n")
            track_suf = suffixes.to_h{|suffix| [suffix, false]}
            lines = rhyme.rhyme_random.split("\n")
            prev_line = ""
            lines.each do |line|
                line = line.delete_prefix(rhyme.start_string)
                before_line = prev_line
                prev_line = line
                line = line.delete_suffix(before_line).strip.chomp(".")
                if suffixes.include? line 
                    track_suf[line] = true
                end 
            end
            expect(track_suf.values).to all(be true)
        end
    end    
end
