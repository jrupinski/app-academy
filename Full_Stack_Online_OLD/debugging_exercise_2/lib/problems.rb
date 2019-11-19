# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"

def largest_prime_factor(number)
    number.downto(2) do |factor|
        if number % factor == 0 && is_prime?(factor)
            return factor
        end 
    end
end

def is_prime?(number)
    return false if number < 2

    (2...number).none? { |factor| number % factor == 0 }
end

def unique_chars?(string)
    char_count = Hash.new(0)
    string.downcase.each_char { |char| char_count[char] += 1 }
    char_count.none? { |k, v| v > 1 }
end

def dupe_indices(array)
    dupes = Hash.new { |h, k| h[k] = []}
    # debugger
    array.each_with_index do |ele, i|
        dupes[ele] << i
    end

    dupes.select { |k, v| v.length > 1}
end

def ana_array(array1, array2)
    # array1 = sort_array(array1)
    # array2 = sort_array(array2)
    array1 = ele_count(array1)
    array2 = ele_count(array2)
    array1 == array2
end


def ele_count(array)
    count = Hash.new(0)
    array.each { |ele| count[ele] += 1 }
    count
end
def sort_array(array)
    sorted = false
    while !sorted
        sorted = true
        
        (0...array.length - 1).each do |idx|
            if array[idx] > array[idx+1]
                array[idx], array[idx+1] = array[idx+1], array[idx]
                sorted = false
            end
        end
    end

    return array
end

print sort_array([6,5,4,3,2,6,1,2])
