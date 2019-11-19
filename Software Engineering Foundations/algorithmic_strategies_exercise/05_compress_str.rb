# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
  # compressed = ""
  # curr_char = nil
  # count = 1
  
  # i = 0
  # while i < str.length
  #   curr_char = str[i]
  #   next_char = str[i + 1]

  #   if curr_char == next_char
  #     count += 1
  #   elsif count > 1
  #     compressed += count.to_s + curr_char
  #     count = 1
  #   else
  #     compressed += curr_char
  #     count = 1
  #   end

  #   i += 1
  # end

  # compressed

# end


  compressed = ""

  i = 0
  while i < str.length
    char = str[i]
    
    count = 0
    while char == str[i]
      count += 1
      i += 1
    end

    if count > 1
      compressed += (count.to_s + char)
    else
      compressed += char
    end

  end
  
  compressed
end

  # str.chars.each do |char|
  #   if char != curr_char
  #     puts curr_char
  #     puts char
  #     if count > 1
  #       compressed += count.to_s + curr_char
  #     else
  #       compressed += curr_char
  #     end

  #     curr_char = char
  #     count = 1
  #   end
  #   count += 1
    
  # end

#   compressed
# end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
