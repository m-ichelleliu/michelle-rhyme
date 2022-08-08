class Rhyme 
    def initialize
        @start_string = "This is"
        
        # Read each individual chunk of words
        @suffixes = File.read("suffixes.txt").split("\n")

    end
    
    attr_reader :start_string

    # Print the whole thing via brute force
    def easy
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
    def hard
        generate_rhyme @suffixes.reverse
   end
    
    # Mix up the phrases and then print with the pattern
    def random
        generate_rhyme @suffixes.shuffle
    end

    # Mix up phrases, but make sure "the house that Jack built" is always last
    def semirandom
        generate_rhyme(@suffixes[0..-2].shuffle, @suffixes[-1])
    end

    # Generate the rhyme given an array of suffixes, with an optional argument being
    # the string that should always be the last suffix.
    def generate_rhyme(suffixes, seed=suffixes[0])
        # Loop through array of word chunks, building on the previous output
        lines = ["#{@start_string} #{seed}."]
        suffixes[0..-1].inject(seed) do |prev_suffix, suffix|
            if suffix == seed 
                next prev_suffix 
            end
            end_of_this_line = "#{suffix} #{prev_suffix}"
            this_line = "#{@start_string} #{end_of_this_line}."
            lines.push(this_line)
            end_of_this_line
        end
        lines.join("\n")
    end 
end