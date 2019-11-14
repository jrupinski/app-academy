require "byebug"

# GENERAL PROBLEMS
def no_dupes?(arr)
  arr.reject do |ele|
    # debugger
    arr.count(ele) > 1
  end
end

def no_consecutive_repeats?(arr)
  (0...arr.length - 1).each do |i|
    return false if arr[i] == arr[i + 1]
  end

  true
end

# Takes a string as an
def char_indices(str)
  char_hash = Hash.new { |h, k| h[k] = [] }

  str.chars.each_with_index { |char, i| char_hash[char] << i }

  char_hash
end

def longest_streak(str)
  char_streaks = Hash.new(0)
  str.chars.each { |char| char_streaks[char] += 1 }

  char_streaks.inject("") do |max_streak, (char, streak)|
    if (char * streak).length >= max_streak.length
      char * streak
    else
      max_streak
    end
  end
end

def bi_prime?(num)
  prime_nums = (0..num).select { |i| prime?(i) } 

  prime_nums.any? do |prime_1|
    prime_nums.any? do |prime_2|
      prime_1 * prime_2 == num
    end
  end
end

def prime?(num)
  return false if num <= 1
  (2...num).none? { |i| num % i == 0 }
end

# Vigenere cipher a single word. Exercise asks for downcase only.
# Improved it a bit by working with symbols and upcase chars 
def vigenere_cipher(word, key_seq_arr)
  return word if key_seq_arr.empty?
  
  ciphered = ""
  word.chars.each_with_index do |char, i|
    # Can't modulo/divide by zero, so take first key manually
    if i == 0 || key_seq_arr.length == 1
      ciphered += cipher_char(char, key_seq_arr.first)
    else
      curr_key = i % key_seq_arr.length
      ciphered += cipher_char(char, key_seq_arr[curr_key])
    end
  end

  ciphered
end

# Cipher a single char by a key. Takes a char and an int(key) as parameters. 
def cipher_char(char, key)
  alpha = ("a".."z").to_a
  alpha_upcase = ("A".."Z").to_a

  # return char if it's not an alphabetic symbol
  return char if !alpha.include?(char.downcase)

  is_upcase = (alpha.include?(char.downcase) && !alpha.include?(char))

  old_char = alpha.index(char.downcase)
  new_char = (old_char + key) % alpha.length # Loop back on alpha array
  
  if is_upcase
    return alpha[new_char].upcase
  else
    return alpha[new_char]
  end
end

# params: string
# returns string where each vowel has it's place swapped with it's predecessor
# first vowel swaps with last one
# ex. vowel_rotate('awesome') # => "ewasemo"
def vowel_rotate(string)
  vowels = "aeiou"
  rotated = string.dup
  
  last_vow = string.chars.reverse_each { |char| break char if vowels.include?(char) }
  prev_vow = nil

  string.each_char.with_index do |char, i|
    # if vowel - replace with previous vowel
    if vowels.include?(char)
      # if it's the first vowel - replace with last vowel
      if prev_vow.nil?
        prev_vow = char
        rotated[i] = last_vow
        next
      end

      rotated[i] = prev_vow
      prev_vow = char
    end
  end

  rotated
end

# PROCS PROBLEMS

class String
  # argument: code block
  # returns a new string containing chars that evaluate the block to true 
  def select(&prc)
    return "" if prc.nil?

    selected = ""
    self.each_char { |char| selected += char if prc.call(char) }
    
    selected
  end

  # args: code block
  # modifies self to contain chars which, when given to block, equal true
  def map!(&prc)
    return "" if prc.nil?

    test = ""
    self.each_char.with_index do |c, i|
      test += prc.call(c) || ""
    end

    self.replace(test)
  end
end
