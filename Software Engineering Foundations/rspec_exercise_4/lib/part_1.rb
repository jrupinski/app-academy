# PART 1
def my_reject(arr, &prc)
    rejected = []
    arr.each { |ele| rejected << ele if prc.call(ele) == false }
    rejected
end

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

def hash_select(hash, &prc)
    selected = { }
    hash.each { |k, v| selected[k] = v if prc.call(k, v) }
    selected
end

def xor_select(arr, prc1, prc2)
    xor_selected = []
    arr.each { |ele| xor_selected << ele if prc1.call(ele) ^ prc2.call(ele) }
    xor_selected
end

def proc_count(val, procs_arr)
    procs_arr.count { |proc| proc.call(val) }
end

# PART 2
def proper_factors(num)
    (1...num).select { |i| num % i == 0 }
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    aliquot_sum(num) == num
end

def ideal_numbers(n)
    ideal_arr = []
    i = 1
    while ideal_arr.length != n
        ideal_arr << i if perfect_number?(i)
        i += 1
    end
    ideal_arr
end