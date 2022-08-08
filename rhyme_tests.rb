# Test suites
def starts_with_start_string?(rhyme, start_string)
    lines = rhyme.split("\n")
    test_passes = true
    lines.each do |line|
        if !line.start_with?(start_string) then test_passes = false end
    end
    test_passes
end

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

def all_suffixes_used_once?(rhyme, start_string)
    suffixes = File.read("suffixes.txt").split("\n")
    track_suf = suffixes.to_h{|suffix| [suffix, false]}
    lines = rhyme.split("\n")
    prev_line = ""
    lines.each do |line|
        line = line.delete_prefix(start_string)
        before_line = prev_line
        prev_line = line
        line = line.delete_suffix(before_line).strip.chomp(".")
        if suffixes.include? line 
            track_suf[line] = true
        end 
    end
    track_suf.values.all? {|value| value == true}
end