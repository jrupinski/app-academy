def hipsterfy(word)
  vowels = "aeiou"

  i = word.length - 1
  while i > 0
    return (word[0...i] + word[i+1..-1]) if vowels.include?(word[i])
    i -= 1
  end

  word
end

def vowel_counts(str)
  vowels = "aeiou"
  count = Hash.new(0)

  str.each_char { |char| count[char.downcase] += 1 if vowels.include?(char.downcase) }


  count
end

def caesar_cipher(msg, n)
  alpha = ("a".."z").to_a
  
  cipher = msg.split("").map do |char|

    if alpha.include?(char.downcase)
      idx = alpha.index(char)
      new_idx = (idx + n) % alpha.length
      alpha[new_idx]
    else
      char
    end
    
  end

  cipher.join("")

end
