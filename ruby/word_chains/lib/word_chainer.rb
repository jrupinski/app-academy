require "byebug"
require "set"

#
# Build a chain of words connecting the first to the second. 
# Each word in the chain must be in the dictionary and every step along 
# the chain changes exactly one letter from the previous word.
#
class WordChainer
  def initialize(dictionary_file_name)
    dictionary_file = File.read(dictionary_file_name).split("\n")
    @dictionary = Set.new(dictionary_file)

    puts @dictionary
  end
end

if __FILE__ == $PROGRAM_NAME
  WordChainer.new(ARGV[0] || "dictionary.txt")
end