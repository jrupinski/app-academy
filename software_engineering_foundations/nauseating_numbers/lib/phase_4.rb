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
