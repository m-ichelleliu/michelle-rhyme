require 'spec_helper'
require_relative '../rhyme.rb'

describe Rhyme do
    let(:rhyme) {Rhyme.new}
    let(:answer) {File.read('jack.txt')}

    describe '#easy' do
        it 'returns the rhyme string' do
            expect(rhyme.easy).to eq(answer)
        end
    end

    describe '#hard' do
        it 'returns the rhyme string' do
            expect(rhyme.hard).to eq(answer)
        end
    end

    describe '#random' do
        it 'all starts with the starting string' do
            lines = rhyme.random.split("\n")
            lines.each {|line| expect(line).to start_with(rhyme.start_string)}
        end
        
        it 'ends each line with the previous line (minus starting string)' do
            expect(lines_are_cumulative?(rhyme.random, rhyme.start_string)).to eq(true)
        end

        it 'uses each phrase from the suffixes.txt file exactly once' do
            track_suf = suffixes_used(rhyme.random, rhyme.start_string)
            expect(track_suf.values).to all(be true)
        end

        it 'generates a new rhyme every time' do
            # this has a 1 in 479,001,600 chance of a false fail
            expect(rhyme.random).not_to be(rhyme.random)
        end
    end    

    describe '#semirandom' do
        it "always ends with 'the house that Jack built'" do
            lines = rhyme.semirandom.split("\n")
            lines.each do |line|
                expect(line.end_with?("the house that Jack built.")).to eq(true)
            end
        end

        # Same tests as randomized rhyme
        it 'all starts with the starting string' do
            lines = rhyme.semirandom.split("\n")
            lines.each {|line| expect(line).to start_with(rhyme.start_string)}
        end
        
        it 'ends each line with the previous line (minus starting string)' do
            expect(lines_are_cumulative?(rhyme.semirandom, rhyme.start_string)).to eq(true)
        end

        it 'uses each phrase from the suffixes.txt file exactly once' do
            track_suf = suffixes_used(rhyme.semirandom, rhyme.start_string)
            expect(track_suf.values).to all(be true)
        end

        it 'generates a new rhyme every time' do
            # this has a 1 in 39,916,800 chance of a false fail.
            expect(rhyme.semirandom).not_to be(rhyme.semirandom)
        end
    end
end

# Test helpers
def lines_are_cumulative?(rhyme, start_string)
    lines = rhyme.split("\n")
    prev_line = ""
    test_passes = true
    lines.each do |line|
        line = line.delete_prefix(start_string)
        if !line.end_with?(prev_line) then test_passes = false end
        prev_line = line
    end
    test_passes 
end

def suffixes_used(rhyme, start_string)
    suffixes = File.read("suffixes.txt").split("\n")
    track_suf = suffixes.to_h{|suffix| [suffix, false]}
    lines = rhyme.split("\n")
    prev_line = ""
    lines.each do |line|
        line = line.delete_prefix(start_string)
        before_line = prev_line
        prev_line = line
        line = line.delete_suffix(before_line).strip.chomp(".")

        expect(track_suf[line]).to eq(false)
        expect(suffixes).to include(line)

        # If the suffix has already been used, fail the test
        if track_suf[line] == true 
            track_suf[line] = false 
            break
        end
        # Make sure that the suffix of the line is a part of the suffixes file
        if suffixes.include? line  
            track_suf[line] = true
        else 
            break
        end 
    end
    track_suf
end
