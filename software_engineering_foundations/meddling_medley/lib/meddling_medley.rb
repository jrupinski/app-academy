require "byebug"
# Phase 1: Modest problems
def duos(string)
  (0...string.length - 1).count do |char|
    string[char] == string[char + 1]
  end
end

def sentence_swap(sentence, word_replacements)
  sentence
    .split
    .map { |word| word_replacements[word] || word }
    .join(" ")
end

def hash_mapped(hash, proc, &block)
  mapped = {}
  hash.map { |k, v| mapped[block.call(k)] = proc.call(v) }
  mapped
end

def counted_characters(string)
  char_count = Hash.new(0)
  string.chars.each { |char| char_count[char] += 1 }
  char_count.keys.select { |char| char_count[char] > 2 }
end

def triplet_true?(string)
  return false if string.length < 3

  (0...string.length - 2).each do |char_idx|
    triplet = string[char_idx..char_idx + 2].chars
    return true if triplet.uniq.length == 1
  end

  false
end

def energetic_encoding(string, replacements)
  string
    .split
    .map do |word|
      word
        .chars
        .map { |char| replacements[char] || "?" }
        .join
    end
    .join(" ")
end

def uncompress(string)
  uncompressed = ""
  string
    .chars
    .each_slice(2) { |(char, times)| uncompressed += (char * times.to_i) }
    
  uncompressed
end

# Phase 2: More difficult, maybe?
def conjunct_select(array, *procs)
  array.select { |ele| procs.all? { |proc| proc.call(ele) == true } }
end

def convert_pig_latin(string)
  vowels = "aeiou"
  converted = ""

  string.split(" ").each do |word|
    is_capitalized = (word == word.capitalize)
    
    if word.length < 3
      converted += word
    elsif vowels.include?(word.chars.first.downcase)
      converted += (word + "yay")
    else
      first_vow = get_first_vowel_idx(word)
      word_translated = word[first_vow..-1] + word[0...first_vow] + "ay"
      word_translated.capitalize! if is_capitalized

      converted += word_translated
    end

    converted += " "
  end

  # remove trailing whitespace
  converted.rstrip
end

def get_first_vowel_idx(word)
  vowels = "aeiou"
  word.each_char.with_index { |char, idx| return idx if vowels.include?(char) }
  nil
end

def reverberate(sentence)
  vowels = "aeiou"
  
  sentence.split.map do |word|
    next word if word.length < 3
    
    if vowels.include?(word.chars.last)
      word + word.downcase
    else
      last_vow = get_last_vowel_idx(word)
      word + word[last_vow..-1]
    end

  end
  .join(" ")
end

def get_last_vowel_idx(word)
  vowels = "aeiou"
  last_vow = nil
  word.chars.each.with_index { |char, idx| last_vow = idx if vowels.include?(char) }
  last_vow
end