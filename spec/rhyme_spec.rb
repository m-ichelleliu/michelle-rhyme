require 'spec_helper'
require_relative '../rhyme.rb'
require_relative '../rhyme_tests.rb'

describe Rhyme do
    let(:rhyme) {Rhyme.new}
    let(:answer) {File.read('jack.txt')}

    describe '#rhyme_easy' do
        it 'returns the rhyme string' do
            expect(rhyme.rhyme_easy).to eq(answer)
        end
    end

    describe '#rhyme_hard' do
        it 'returns the rhyme string' do
            expect(rhyme.rhyme_hard).to eq(answer)
        end
    end

    describe '#rhyme_random' do
        it 'all starts with the starting string' do
            expect(starts_with_start_string?(rhyme.rhyme_random, rhyme.start_string)).to eq(true)
        end
        
        it 'ends each line with the previous line (minus starting string)' do
            expect(lines_are_cumulative?(rhyme.rhyme_random, rhyme.start_string)).to eq(true)
        end

        it 'uses each phrase from the suffixes.txt file exactly once' do
            expect(all_suffixes_used_once?(rhyme.rhyme_random, rhyme.start_string)).to eq(true)
        end
    end    

    describe '#rhyme_semirandom' do
        it "always ends with 'the house that Jack built'" do
            lines = rhyme.rhyme_semirandom.split("\n")
            lines.each do |line|
                expect(line.end_with?("the house that Jack built.")).to eq(true)
            end
        end

        # Same tests as randomized rhyme
        it 'all starts with the starting string' do
            expect(starts_with_start_string?(rhyme.rhyme_semirandom, rhyme.start_string)).to eq(true)
        end
        
        it 'ends each line with the previous line (minus starting string)' do
            expect(lines_are_cumulative?(rhyme.rhyme_semirandom, rhyme.start_string)).to eq(true)
        end

        it 'uses each phrase from the suffixes.txt file exactly once' do
            expect(all_suffixes_used_once?(rhyme.rhyme_semirandom, rhyme.start_string)).to eq(true)
        end
    end
end
