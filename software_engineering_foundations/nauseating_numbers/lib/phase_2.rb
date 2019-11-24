require "byebug"

def anti_prime?(num)
  num_divisors = get_divisors(num)
  (0..num).none? do |i|
    i_divisors = get_divisors(i)
    i_divisors.count > num_divisors.count
  end 
end

def get_divisors(num)
  (1..num).select { |i| num % i == 0 }
end

def matrix_addition(mat_1, mat_2)
  mat_sum = []

  (0...mat_1.length).each do |row|
    
    curr_row = []
    (0...mat_1[row].length).each do |col|
      curr_row << (mat_1[row][col] + mat_2[row][col])
    end
    
    mat_sum << curr_row
  end

  mat_sum
end

def mutual_factors(*nums)
  common_factors = get_divisors(nums[0])

  nums.each do |num|
    num_divisors = get_divisors(num)
    common_factors.select! { |div| num_divisors.include?(div) }
  end

  common_factors
end

def tribonacci_number(n)
  tribonacci = tribonacci_sequence(n)
  tribonacci.last
end

def tribonacci_sequence(n)
  case n
    when -Float::INFINITY..0 then return []
    when 1 then return [1]
    when 2 then return [1, 1]
    when 3 then return [1, 1, 2]
  end

  sequence = tribonacci_sequence(n - 1)
  sequence << (sequence[-3] + sequence[-2] + sequence[-1])

  sequence
end