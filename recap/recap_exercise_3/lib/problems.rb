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