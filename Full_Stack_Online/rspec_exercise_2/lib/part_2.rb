def palindrome?(string)
    reversed_string = ""
    word = string.split("")
    word.reverse_each { |char| reversed_string += char }
    
    string.eql?(reversed_string)
end

def substrings(string)
    substrings = []
    
    string.each_char.with_index do |char, idx|
        i = idx
        while i < string.length
            substrings << string[idx..i]
            i += 1
        end
    end

    substrings
end

def palindrome_substrings(string)
    substrings(string).select { |substring| palindrome?(substring) && substring.length > 1 }
end
