require "byebug"

#
# Create a return a 2D array where each subarray contains the elements at the 
# same index from each argument.
# Every subarray's length is equal to number of arguments (*arrays.length)
#
# @param [Array] *arrays any number of arrays
#
# @return [Array] A 2D array with subarrays containg elements at subarray's index
#
def zip(*arrays)
    raise "wrong argument" if arrays.length == 0
    
    arr_length = arrays[0].length
    zipped = Array.new(arr_length) { Array.new }
    
    arrays.each do |array|
        array.each.with_index do |ele, idx|
            zipped[idx] << ele
        end
    end

    zipped
end

#
# Get elements from an array that satisfy one of the two Procs exclusively (XOR).
#
# @param [Array] arr Array of values
# @param [Proc] prc1 Proc 1 for XOR check
# @param [Proc] prc2 Proc 2 for XOR check
#
# @return [Array] Array of values that satisfy XOR condition
#
def prizz_proc(arr, prc1, prc2)
    arr.select { |ele| prc1.call(ele) ^ prc2.call(ele)}
end

#
# Create a return a 2D array where each subarray contains the elements at the 
# same index from each argument.
# If subarray's element number is less than the number of indexes - put in nil.
#
# @param [Array] *arrays any number of arrays
#
# @return [Array] A 2D array with subarrays containg elements at subarray's index
#
def zany_zip(*arrays)
    max_elements = arrays.max { |ele_1, ele_2| ele_1.length <=> ele_2.length}
    zipped = Array.new(max_elements.length) { Array.new }

    (0...arrays.length).each do |arr_idx|
        (0...max_elements.length).each do |ele_idx|
            zipped[ele_idx][arr_idx] = arrays[arr_idx][ele_idx]
        end
    end

    zipped
end

#
# Returns maximum value from array based on the result of the passed block.
#
# @param [Array] arr Array of values
# @param [Proc] &block A block of code 
#
# @return [?] Value type depends on Array's element.
#
def maximum(arr, &block)
    return nil if arr.empty?
    arr.inject do |max, ele|
        if block.call(ele) >= block.call(max)
            max = ele
        else
            max
        end
    end
end

#
# Custom implementation of Enumerable#group_by that works on an Array.
#
# @param [Array] arr Array of values
# @param [Proc] &block Custom block of code
#
# @return [Hash] Keys the results when the elements are given to the block.
# Each value is an array containing the elements that result in the 
# corresponding key when given to the block.
#
def my_group_by(arr, &block)
    grouped = {}
    arr.each do |ele|
        key = block.call(ele)
        val = arr.select { |ele_val| block.call(ele_val) == key }
        grouped[key] = val
    end
    grouped
end


#
# Get maximum value from Array based on output from block of code.
# If there's a tie - choose maximum value based on output from Proc.
#
# @param [Array] arr Array of values
# @param [Proc] prc Proc to use when block of code equals in a tie
# @param [Proc] &block Block of code, used to check each value
#
# @return [Value] Maximum value, type of which depends on Array's elements. 
#
def max_tie_breaker(arr, prc, &block)
    return nil if arr.empty?

    arr.inject do |max, ele|
        if block.call(ele) > block.call(max)
            max = ele
        elsif block.call(ele) == block.call(max)

            if prc.call(ele) > prc.call(max)
                max = ele 
            else
                max
            end

        else 
            max
        end
    end
end

#
# Return a new sentence where all letters before the first vowel and after the
# last vowel are removed. Method should not remove letters for words that 
# contain less than two vowels.
#
# @param [String] sent A string sentence
#
# @return [String] New string
#
def silly_syllables(sent)
    words = sent.split(" ")
    words.map! do |word|
        word_vowels = get_vowel_indexes(word)

        if word_vowels.length < 2
            word
        else
            first_vow_idx = word_vowels.first
            last_vow_idx = word_vowels.last
            word[first_vow_idx..last_vow_idx]
        end
    end
    words.join(" ")
end

#
# Get index of every vowel in a sentence.
#
# @param [String] sent A String sentence
#
# @return [Array] Array of numbered indexes of every vowel in the sentence
#
def get_vowel_indexes(sent)
    vowels = "aeiou"
    (0...sent.length).select { |idx| vowels.include?(sent[idx]) }
end
