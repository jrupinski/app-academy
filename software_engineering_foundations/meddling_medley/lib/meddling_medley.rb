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