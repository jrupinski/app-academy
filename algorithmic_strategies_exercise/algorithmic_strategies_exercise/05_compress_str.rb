# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    streak = 1
    string = str.split("")

    (1..string.length).each do |i|
        if str[i - 1] == str[i]
            string[i - 1] = ""
            streak += 1
        else
            string[i - 2] = streak.to_s if streak > 1
            streak = 1
        end
    end

    return string.join("")
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
