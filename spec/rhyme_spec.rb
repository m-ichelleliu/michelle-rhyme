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
            lines = rhyme.random.split("\n")
            lines.inject("") do |prev_line, line|
                line = line.delete_prefix(rhyme.start_string)
                expect(line).to end_with(prev_line)
                line
            end
        end

        it 'uses each phrase from the suffixes.txt file exactly once' do
            track_suf = suffixes_used(rhyme.random, rhyme.start_string)
            expect(track_suf.values).to all(be true)
        end

        it 'generates a new rhyme every time' do
            # this has a 1 in 479,001,600 chance of a false fail. (factorial of lines in suffixes.txt)
            expect(rhyme.random).not_to be(rhyme.random)
        end
    end    

    describe '#semirandom' do
        it "always ends with 'the house that Jack built'" do
            lines = rhyme.semirandom.split("\n")
            lines.each {|line| expect(line).to end_with("the house that Jack built.")}
        end

        # Same tests as randomized rhyme
        it 'all starts with the starting string' do
            lines = rhyme.semirandom.split("\n")
            lines.each {|line| expect(line).to start_with(rhyme.start_string)}
        end
        
        it 'ends each line with the previous line (minus starting string)' do
            lines = rhyme.semirandom.split("\n")
            lines.inject("") do |prev_line, line|
                line = line.delete_prefix(rhyme.start_string)
                expect(line).to end_with(prev_line)
                line
            end
        end

        it 'uses each phrase from the suffixes.txt file exactly once' do
            track_suf = suffixes_used(rhyme.semirandom, rhyme.start_string)
            expect(track_suf.values).to all(be true)
        end

        it 'generates a new rhyme every time' do
            # this has a 1 in 39,916,800 chance of a false fail. (factorial of (lines in suffixes.txt - 1))
            expect(rhyme.semirandom).not_to be(rhyme.semirandom)
        end
    end
end

# Test helpers

def suffixes_used(rhyme, start_string)
    suffixes = File.read("suffixes.txt").split("\n")
    track_suf = suffixes.to_h{|suffix| [suffix, false]}
    lines = rhyme.split("\n")
    lines.inject("") do |prev_line, line|
        current_line = line.delete_prefix(start_string)
        line = current_line.delete_suffix(prev_line).strip.chomp(".")
        # would be nice for these tests to exist directly in the it block, but not sure
        # how I would do that besides pasting the entire function twice
        expect(track_suf[line]).to eq(false) # Make sure the line hasn't already been used
        expect(suffixes).to include(line) # Make sure the suffix is in our suffixes.txt
        if suffixes.include? line # if this isn't true the above line would fail anyway
            track_suf[line] = true
        end
        current_line
    end
    track_suf
end
