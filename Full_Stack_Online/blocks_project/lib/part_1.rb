require "byebug"

def select_even_nums(array)
    array.select(&:even?)
end

def reject_puppies(dogs)
    dogs.reject { |dog| dog["age"] <= 2 }
    # dogs.reject(&["age"] <= 2)
end

def count_positive_subarrays(array)
    # array.count(&:sum > 0)
    array.count { |sub_array| sub_array.sum > 0 }
end

def aba_translate(word)
    vowels = "aeiou"
    translated = ""
    word.chars do |char|
        if vowels.include?(char)
            translated += char + "b"
        end
        
        translated += char
    end
    
    translated
end

def aba_array(word_array)
    word_array.map { |word| aba_translate(word) }
    # word_array.map(aba_translate())
end

