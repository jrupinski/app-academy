require "byebug"

#
# Get n-th mersenne prime 
# 
# A "Mersenne prime" is a prime number that is one less than a power of 2.
# This means that it is a prime number with the form 2^x - 1, where x is some exponent. 
#
# @param [Integer] n Positive-only number
#
# @return [Integer] n-th mersenne prime number
#
def mersenne_prime(n)
  raise "arg has to be a positive num" if !n.is_a?(Integer) || n < 1
  # debugger
  mer_primes = [] 
  i = 1
  until mer_primes.length == n
    mer_primes << i if is_prime?(i) && is_mersenne?(i)
    i += 1
  end
  
  mer_primes.last
end

def is_prime?(num)
  return false if num < 2
  (2...num).none? { |divisor| num % divisor == 0 }
end

def is_mersenne?(num)
  i = 1
  while 2.pow(i) < num
    i += 1
  end

  2.pow(i) - 1 == num
end