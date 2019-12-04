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
