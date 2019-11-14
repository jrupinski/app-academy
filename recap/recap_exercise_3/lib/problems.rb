require "byebug"

# GENERAL PROBLEMS

# args: Array
# returns a new array with distinct elements from the arg array
def no_dupes?(arr)
  arr.reject do |ele|
    # debugger
    arr.count(ele) > 1
  end
end

# args: Array
# returns true if no ele repeats consecutively in array; false otherwise
def no_consecutive_repeats?(arr)
  (0...arr.length - 1).each do |i|
    return false if arr[i] == arr[i + 1]
  end

  true
end

# args: String
# returns a hash with each char as key and indexes of it's appearance in string as values
def char_indices(str)
  char_hash = Hash.new { |h, k| h[k] = [] }
  str.chars.each_with_index { |char, i| char_hash[char] << i }
  char_hash
end

# args: String
# returns new string containing longest consecutive repeats of char in string
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

# args: Integer
# returns true if number is a semi-prime (it's a product of multiplying two prime numbers)
# returns false otherwise
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

# args: String(single word), Array of Integers(keys) 
# returns a new string - vigenere ciphered word Vigenere cipher a single word.
# key is sequentially taken from the key array, which loops back if keys < word.length 
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

# vigenere_cipher helper method
# args: Char, Int
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

# args: string
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
  # args: code block
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

# RECURSION PROBLEMS

# args: 2 integers
# returns product of multiplying args (ints)
def multiply(num_1, num_2)
  return 0 if num_1 == 0 || num_2 == 0
  return num_1 if num_2.abs == 1

  result = 0
  if num_2 > 0
    result = num_1 + multiply(num_1, num_2 - 1)
  else
    # if both nums are negative and num_2 is even - result is positive
    if num_2.even? && num_1 < 0
      num_1 = num_1.abs
      num_2 = num_2.abs
    end

    result = num_1 + multiply(num_1, num_2 + 1)
  end
end