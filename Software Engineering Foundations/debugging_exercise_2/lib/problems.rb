require "byebug"
# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(num)
  
  (1..num).inject do |largest_factor, factor|
    if num % factor == 0 && prime?(factor)
      largest_factor = factor
    else
      largest_factor
    end
  end
end

def prime?(num)
  return false if num <= 1
  (2...num).none? { |factor| num % factor == 0 }
end

def unique_chars?(str)
  char_count = Hash.new(0)

  str.each_char { |char| char_count[char] += 1 }

  char_count.values.none? { |count| count > 1 } 
end

def dupe_indices(arr)
  dupes = Hash.new { |k, v| k[v] = [] }
  # debugger

  arr.each.with_index { |ele, idx| dupes[ele] << idx }

  dupes.select { |k, v| v.length > 1 }
end

def ana_array(arr_1, arr_2)
  arr_1_hash = {}
  arr_2_hash = {}

  arr_1.each { |ele| arr_1_hash[ele] = true }
  arr_2.each { |ele| arr_2_hash[ele] = true }

  arr_1_hash.eql?(arr_2_hash)
end