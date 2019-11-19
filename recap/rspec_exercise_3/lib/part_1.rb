# PART 1
def is_prime?(num)
    return false if num < 2
    (2...num).none? { |factor| num % factor == 0 }
end

def nth_prime(n)
    return [] if n < 1
    
    primes = []
    i = 0
    until primes.length == n
        primes << i if is_prime?(i)
        i += 1
    end

    primes.last
end

def prime_range(min, max)
    (min..max).select do |num|
        is_prime?(num)
    end
end

# PART 2
def element_count(arr)
    ele_count = Hash.new(0)
    arr.each { |ele| ele_count[ele] += 1 }
    ele_count
end

def char_replace!(string,chars_hash)
    string.each_char.with_index do |char, idx|
        new_val = chars_hash[char]
        string[idx] = new_val || char # only modify if key[char] with a val exists
    end
end

def product_inject(num_arr)
    if !num_arr.is_a?(Array) || num_arr.any? { |ele| ele.is_a?(Integer) == false }
        raise "Wrong argument. Use an array of nums." 
    end

    num_arr.inject { |product, ele| product *= ele }
end