require "byebug"

class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(chars)
    chars.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end
  
  def self.random(length)
    pegs = Array.new(length) { POSSIBLE_PEGS.keys.sample } 
    Code.new(pegs)
  end
  
  def self.from_string(string)
    Code.new(string.split(""))
  end
  
  def initialize(pegs)
  if Code.valid_pegs?(pegs)
    @pegs = pegs.map(&:upcase)
    else
      raise "Pegs are invalid"
    end
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  # part 2
  def num_exact_matches(guess_code)
    exact_matches = 0
    (0...guess_code.length).each do |i|
      exact_matches += 1 if guess_code[i] == self[i]
    end

    exact_matches
  end

  def num_near_matches(guess_code)
    near_matches = 0

    # guess_code.pegs.each.with_index do |peg, i|
    #   near_matches +=1 if guess_code[i] != self[i] && self.pegs.include?(peg)
    # end

    (0...guess_code.length).each do |i|
      if guess_code[i] != self[i] && self.pegs.include?(guess_code[i])
        near_matches += 1 
      end
    end

    near_matches
  end

  def ==(other_code)
    self.pegs == other_code.pegs
  end
end
