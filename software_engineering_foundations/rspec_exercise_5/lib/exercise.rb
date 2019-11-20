require "byebug"

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

def prizz_proc(arr, prc1, prc2)
    arr.select { |ele| prc1.call(ele) ^ prc2.call(ele)}
end

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

def my_group_by(arr, &block)
    grouped = {}
    arr.each do |ele|
        key = block.call(ele)
        val = arr.select { |ele_val| block.call(ele_val) == key }
        grouped[key] = val
    end
    grouped
end

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

def get_vowel_indexes(sent)
    vowels = "aeiou"
    (0...sent.length).select { |idx| vowels.include?(sent[idx]) }
end
