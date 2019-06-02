def hipsterfy(word)
    vowels = "aeiou"
    # arr = word.split("")
    # arr.reverse_each do |char|
    #     if vowels.include?(char)
    #         arr.delete_at(index(char))
    #         return arr.join("")
    #     end
    # end

    i = word.length - 1
    while i >= 0
        if vowels.include?(word[i])
            word[i] = ""
            return word
        end

        i -= 1
    end

    word
end

def vowel_counts(str)
    vowels = "aeiou"
    vowel_hash = Hash.new(0)

    str.each_char do |char|
        vowel_hash[char.downcase] += 1 if vowels.include?(char.downcase)
    end

    vowel_hash
end

def caesar_cipher(string, num)
    alphabet = ("a".."z").to_a
    cipher = string.split("")

    cipher.map! do |char|
        if alphabet.include?(char)
            moved_char = (alphabet.index(char) + num) % alphabet.length
            alphabet[moved_char]
        else
            char
        end
    end

    cipher.join("")
end