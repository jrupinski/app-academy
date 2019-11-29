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


#
# Return an Array where we continuously remove consecutive numbers that are 
# adjacent in the array. If multiple adjacent pairs are consecutive numbers, 
# remove the leftmost pair first.
#
# @param [Array] arr Array of whole numbers
#
# @return [Array] Array of numbers, collapsed
#
def consecutive_collapse(arr = [])
  raise "Wrong arg - array of numbers only" if !arr.is_a?(Array) ||
    arr.all? { |ele| !ele.is_a?(Integer) }
  
  return arr if arr.length == 1

  collapsed = arr.clone
  is_collapsed = false
  
  while !is_collapsed
    is_collapsed = true
    
    (0...collapsed.length - 1).each do |i|
      
      pair = collapsed[i..i + 1]
      pair_idx = (i..i + 1)
      if is_consecutive?(pair.first, pair.last)
        collapsed.slice!(pair_idx)
        is_collapsed = false
        break
      end

    end
  end

  collapsed
end

#
# Check if numbers are consecutive to each other
# 
# Examples: 
# is_consecutive?(1,2) => true
# is_consecutive?(2,1) => true
# is_consecutive?(1,3) => false
# is_consecutive?(5,3) => false
#
# @param [Integer] num_1 Whole number
# @param [Integer] num_2 Whole number
#
# @return [Boolean] Indicates if numbers are consecutive
#
def is_consecutive?(num_1, num_2)
  num_1 + 1 == num_2 || num_1 - 1 == num_2
end

#
# The method should return a new array where each element of the original array 
# is replaced according to the following rules:
#
#   - when the number argument is positive, replace an element with the n-th 
#   nearest prime number that is greater than the element
# 
#   - when the number argument is negative, replace an element with the n-th
#   nearest prime number that is less than the element
# 
# Note that we will always be able to find a prime that is greater than a given 
# number because there are an infinite number of primes (this is given by 
# Euclid's Theorem). However, we may be unable to find a prime that is smaller 
# than a given number, because 2 is the smallest prime. When a smaller prime 
# cannot be calculated, replace the element with nil.
#
# @param [Array] arr Array of whole numbers
# @param [Integer] num Whole number
#
# @return [Array] New array with replaced elements (if needed)
#
def pretentious_primes(arr = nil, n = nil)
  # error checking
  if arr.nil? || n.nil? || !arr.is_a?(Array) || !n.is_a?(Integer) || 
      arr.any? { |ele| !ele.is_a?(Integer) }
    raise "Use array of numbers and a number as arguments"
  end
  
  # debugger
  return arr if n == 0
  arr.map { |num| nearest_prime(num, n) }
end

#
# Get n-th next/previous prime relative to given number. Return biggest 
# prime if n == 0. If smaller prime neighbor is less than 2 - replace 
# it with nil.
#
# Example:
# nearest_prime(5, 0)   => 5
# nearest_prime(5, 1)   => 7
# nearest_prime(5, -1)  => 3
# nearest_prime(5, -2)  => 2
# nearest_prime(5, -3)  => nil
#
#
# @param [Integer] num A number to look for prime for
# @param [Integer] n A positive or negative number, indicating n-th prime
#
# @return [Integer || nil] n-th previous/next prime number. Return nil if 
# n-th previous prime is less than 2.
#
def nearest_prime(num, n)
  primes = get_primes(num)
  max_prime_idx = primes.length - 1

  # debugger
  if n < 0
    smaller_prime_idx = max_prime_idx + n
    # if num is bigger than it's max prime - count going to it as one of N steps
    smaller_prime_idx += 1 if num > primes.last

    if smaller_prime_idx < 0
      nil
    else
      primes[smaller_prime_idx]
    end

  else
    get_n_primes(primes.length + n).last
  end
end

#
# Check if a number is prime
#
# @param [Integer] num Number to check if it's prime
#
# @return [Boolean] Indication if number is a prime number
#
def is_prime?(num)
  return false if num < 2
  (2...num).none? { |div| num % div == 0 }
end

#
# Get all primes of given number.
#
# @param [Integer] num A number to get primes off of.
#
# @return [Array] An array of primes up to number argument.
#
def get_primes(num)
  return nil if num < 2
  
  primes = []
  i =  2
  until i > num
    primes << i if is_prime?(i)
    i += 1
  end

  primes
end

#
# Create an array filled with n consecutive primes.
#
# @param [Integer] n How many primes to include
#
# @return [Array] An array filled with n-amount primes.
#
def get_n_primes(n)
  return [] if n < 1
  primes = []

  i = 2
  until primes.length == n
    primes << i if is_prime?(i)
    i += 1
  end

  primes
end