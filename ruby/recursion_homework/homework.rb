# App Academy
# RUBY section
# Recursion Homework

# Write a function sum_to(n) that uses recursion to calculate the sum from 1 to n (inclusive of n).
def sum_to(n)
  return n if n <= 1
  n + sum_to(n - 1)
end

# Write a function add_numbers(nums_array) that takes in an array of Integers and returns the sum of those numbers.
def add_numbers(nums_array)
  return nums_array.first if nums_array.length <= 1
  nums_array.first + add_numbers(nums_array[1..-1])
end

# Let's write a method that will solve Gamma Function recursively.
# The Gamma Function is defined Γ(n) = (n-1)!. 
def solve_gamma_function
  # TODO
end

# Write a function ice_cream_shop(flavors, favorite) that takes in an array of ice cream flavors available at the ice cream shop, as well as the user's favorite ice cream flavor.
# Recursively find out whether or not the shop offers their favorite flavor.
def ice_cream_shop
  # TODO
end

# Write a function reverse(string) that takes in a string and returns it reversed.
def reverse
  # TODO
end