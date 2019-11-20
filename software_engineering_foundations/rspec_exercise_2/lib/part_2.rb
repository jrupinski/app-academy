def palindrome?(str)
  reversed = ""

  str.chars.reverse_each { |char| reversed += char }
  str.eql?(reversed)
end

def substrings(string)
  pairs = []

  string.chars.each.with_index do |char_1, idx_1|

    string.chars.each.with_index do |char_2, idx_2|
      pairs << string[idx_1..idx_2] if idx_2 >= idx_1
    end

  end

  pairs
end

def palindrome_substrings(str)
  substrings(str).select { |sub_str| palindrome?(sub_str) && sub_str.length > 1 }
end