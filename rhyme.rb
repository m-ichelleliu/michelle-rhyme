class Rhyme 
    def initialize
        @start_string = "This is"
        
        # Read each individual chunk of words
        @suffixes = File.read("suffixes.txt").split("\n")

    end
    
    attr_reader :start_string

    # Print the whole thing via brute force
    def rhyme_easy
        "This is the house that Jack built.
This is the malt that lay in the house that Jack built.
This is the rat that ate the malt that lay in the house that Jack built.
This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
    end    

    # Print more algorithmically, since there is a pattern
    def rhyme_hard
        generate_rhyme @suffixes.reverse
   end
    
    # Mix up the phrases and then print with the pattern
    def rhyme_random
        generate_rhyme @suffixes.shuffle
    end

    # 
    def rhyme_semirandom
        suff = @suffixes[0..-2] #Suffixes without the house that Jack built
        prev_line = @suffixes[-1] + '.' #The house that Jack built, as a base
        lines = [@start_string + ' ' + prev_line]
        suff.each do |suffix|
            end_of_this_line = suffix + ' ' + prev_line
            prev_line = end_of_this_line 
            this_line = @start_string + ' ' + end_of_this_line
            lines.push(this_line)
        end
        lines.join("\n")
    end

    def generate_rhyme(suffixes)
        # Loop through array of word chunks, building on the previous output
        lines = Array.new
        prev_line = ""
        suffixes.each do |suffix|
            end_of_this_line = suffix
            unless prev_line == "" then end_of_this_line += " " end # Corner case; we want no space between last phrase and period.
            end_of_this_line += prev_line
            prev_line = end_of_this_line 
            this_line = @start_string + " " + end_of_this_line + "."
            lines.push(this_line)
        end
        lines.join("\n")
    end 
end