require "byebug"

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
