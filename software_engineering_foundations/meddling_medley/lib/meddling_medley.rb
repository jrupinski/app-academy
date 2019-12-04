require "byebug"
# Phase 1: Modest problems
def duos(string)
  (0...string.length - 1).count do |char|
    string[char] == string[char + 1]
  end
end
