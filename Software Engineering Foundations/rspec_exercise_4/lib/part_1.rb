# PART 1

# Custom implementation of Array#reject. Returns elements that return false
# when passed into a block.
def my_reject(arr, &prc)
    rejected = []
    arr.each { |ele| rejected << ele if prc.call(ele) == false }
    rejected
end

# Custom implementation of Array#one?. Checks if only one ele returns true
# when passed into a block.
def my_one?(arr, &prc)
    has_one = false
    arr.each do |ele|
        if prc.call(ele) == true
            if !has_one
                has_one = true
            else
                return false
            end
        end
    end
    has_one
end

# Returns a new Hash, containing key-value pairs that return true when passed 
# into a block.
def hash_select(hash, &prc)
    selected = { }
    hash.each { |k, v| selected[k] = v if prc.call(k, v) }
    selected
end

# Returns a new Array, containing elements that are exclusive between two
# procs, ie. when only one of procs returns true.
def xor_select(arr, prc1, prc2)
    xor_selected = []
    arr.each { |ele| xor_selected << ele if prc1.call(ele) ^ prc2.call(ele) }
    xor_selected
end

# Returns how many times value returned true when passed through an array
# of procs. 
def proc_count(val, procs_arr)
    procs_arr.count { |proc| proc.call(val) }
end

# PART 2

# Return all factors up to num.
def proper_factors(num)
    (1...num).select { |i| num % i == 0 }
end

# Return sum of factors up to num.
def aliquot_sum(num)
    proper_factors(num).sum
end

# Check if given number is equal to the sum of it's prime numbers.
def perfect_number?(num)
    aliquot_sum(num) == num
end

# Return n numbers where num equals sum of it's prime nums. 
def ideal_numbers(n)
    ideal_arr = []
    i = 1
    while ideal_arr.length != n
        ideal_arr << i if perfect_number?(i)
        i += 1
    end
    ideal_arr
end