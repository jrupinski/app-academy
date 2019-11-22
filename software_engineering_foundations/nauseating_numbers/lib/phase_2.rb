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
  mat_sum = Array.new(mat_1.length) { Array.new(mat_1[0].length) }

  (0...mat_1.length).each do |row|
    (0...mat_1[row].length).each do |col|
      mat_sum[row][col] = mat_1[row][col] + mat_2[row][col]
    end
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

def tribonacci_number(num)
  tribonacci = [1, 1, 2]

  # arrays starts at zero, user starts count at one - subtract 1
  return tribonacci[num - 1] if num < 3

  until tribonacci.length == num
    first_ele = tribonacci[-3]
    second_ele = tribonacci[-2]
    third_ele = tribonacci[-1]

    tribonacci << (first_ele + second_ele + third_ele)
  end
  
  tribonacci[num - 1]
end