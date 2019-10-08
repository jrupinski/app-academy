VOWELS = "aeiou"

def partition(arr, num)
  less = []
  more = []

  arr.each do |ele|
    if ele < num
      less << ele
    else
      more << ele
    end
  end

  [less, more]
end

def merge(hash_1, hash_2)
  merged = Hash.new

  hash_1.each { |k, v| merged[k] = v if !hash_2.keys.include?(k) }
  hash_2.each { |k, v| merged[k] = v }

  merged
end

def censor(sentence, arr_curse_words)
  words = sentence.split(" ")

  words = words.map do |word|
    if arr_curse_words.include?(word.downcase)
      censored = word.each_char.map { |char| ("*" if VOWELS.include?(char.downcase)) || char }
      censored.join("")
    else
      word
    end
  end

  words.join(" ")
end

def power_of_two?(num)
  return false if num < 1
  
  i = 1
  while num >= i
    return true if i == num
    i *= 2
  end

  false
end