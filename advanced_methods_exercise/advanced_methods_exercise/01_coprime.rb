# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def coprime?(num_1, num_2)
  num_1_divisors = []
  num_2_divisors = []

  1.upto(num_1) do |factor|
    num_1_divisors << factor if num_1 % factor == 0
  end

  1.upto(num_2) do |factor|
    num_2_divisors << factor if num_2 % factor == 0
  end

  # check if one is the only common divisor
  num_1_divisors.one? { |el| num_2_divisors.include?(el) }
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
