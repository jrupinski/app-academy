require "byebug"

def strange_sums(arr)
  count = 0

  (0...arr.length - 1).each do |ele_1|
    (ele_1 + 1...arr.length).each do |ele_2|
      count += 1 if arr[ele_1] + arr[ele_2] == 0
    end
  end

  count
end

def pair_product(arr, product)
  (0...arr.length - 1).each do |ele_1|
    (ele_1 + 1...arr.length).each do |ele_2|
      return true if arr[ele_1] * arr[ele_2] == product
    end
  end

  false
end

def rampant_repeats(str, hash)
  repeated = str.each_char.map do |char|
    # debugger
    num_of_repeats = hash[char] || 1
    char * num_of_repeats
  end

  repeated.join("")
end

def perfect_square?(num)
  (0..num).any? { |i| i * i == num }
end
