def select_even_nums(arr)
  arr.select(&:even?)
end

def reject_puppies(arr_dog_hashes)
  arr_dog_hashes.reject { |dog| dog["age"] <= 2 }
end

def count_positive_subarrays(arr)
  arr.count { |sub_arr| sub_arr.sum > 0}
end

def aba_translate(str)
  vowels = "aeiou"
  translated = ""

  str.each_char do |char|
    if vowels.include?(char)
      translated += (char + "b" + char)
    else
      translated += char
    end
  end
  
  translated
end

def aba_array(words_arr)
  words_arr.map { |word| aba_translate(word) }
end