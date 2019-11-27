require "byebug"

#
# Get n-th Mersenne prime 
# 
# @param [Integer] n Positive number
#
# @return [Integer] n-th Mersenne prime number
#
def mersenne_prime(n)
  raise "arg has to be a positive num" if !n.is_a?(Integer) || n < 1
  mer_primes = [] 
  i = 1
  until mer_primes.length == n
    mer_primes << i if is_prime?(i) && is_mersenne?(i)
    i += 1
  end
  
  mer_primes.last
end

#
# Check if number is a Prime number
#
# @param [Integer] num Number to check
#
# @return [Boolean] Return true if number is prime, false otherwise
#
def is_prime?(num)
  return false if num < 2 || !num.is_a?(Integer)
  (2...num).none? { |divisor| num % divisor == 0 }
end

#
# Check if prime is a Mersenne prime
#
# A "Mersenne prime" is a prime number that is one less than a power of 2.
# This means that it is a prime number with the form 2^x - 1, where x is 
# some exponent. 
#
# @param [Integer] prime Prime number.
#
# @return [Boolean] True if prime is a Mersenne prime, false otherwise.
#
def is_mersenne?(prime)
  i = 1
  while 2.pow(i) < prime
    i += 1
  end

  2.pow(i) - 1 == prime
end

#
# Check if word, when encoded using sum of it's letters in the alphabet,
# is triangular. 
# Example:
# "cat" encoded is 24 because "c" is the 3rd of the alphabet, "a" is the 1st, 
# and "t" is the 20th:
# 3 + 1 + 20 = 24
#
# @param [String] word Lowercase word
#
# @return [Boolean] Indicates if sum of encoded chars in word is triangular
#
def triangular_word?(word)
  # debugger
  alpha = ("a".."z").to_a

  word_encoded = word.chars.inject(0) do |sum, char|
    char_encoded = alpha.index(char) + 1 # start alpha encoding at 1, not 0
    sum += char_encoded
  end

  is_triangular?(word_encoded)
end

#
# Checks if given number is triangular.
# A triangular number is a number of the form (i * (i + 1)) / 2 where i is
# some positive integer.
# Substituting i with increasing integers gives the triangular number sequence.
#
# @param [Integer] num A positive number
#
# @return [Boolean] Boolean indicating if number is triangular
#
def is_triangular?(num)
  tri_nums = [1]

  i = 2
  until tri_nums.last >= num
    tri_number = (i * (i + 1)) / 2
    tri_nums << tri_number
    i += 1
  end

  tri_nums.last == num
end
