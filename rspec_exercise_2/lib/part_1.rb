require "byebug"

def partition(array, number)
    new_array = Array.new(2) { Array.new }

    array.each do |ele|
        if ele < number
            new_array[0] << ele
        else
            new_array[1] << ele
        end
    end

    new_array
end

def merge(hash1, hash2)
    new_hash = {}

    hash1.each { |key, value| new_hash[key] = value }
    hash2.each { |key, value| new_hash[key] = value }

    new_hash
end

def censor(sentence, curse_words_array)
    vowels = "aeiou"
    words = sentence.split(" ")

    words.each do |word|
        if curse_words_array.include?(word.downcase)
            word.each_char.with_index do |char, i|
                if vowels.include?(char.downcase)
                    word[i] = "*"
                end
            end
        end
    end
    
    words.join(" ")
end

def power_of_two?(number)
    i = 0
    while 2.pow(i) <= number
        return true if 2.pow(i) == number

        i += 1
    end
    
    false
end

debugger
merge({ key: "elo" }, { test: "melo" })

def check_num(num)  # 1
  if num > 0        # 2
    p "positive"    # 3
  elsif num < 0   # 4
    p "negative"    # 5
  else              # 6
    p "zero"        # 7
  end               # 8
end                 # 9

check_num(0)