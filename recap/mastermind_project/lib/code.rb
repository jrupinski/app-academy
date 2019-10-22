class Code
  # PART 1
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(pegs_arr)
    pegs_arr.all? { |peg| POSSIBLE_PEGS.keys.include?(peg.upcase) }
  end

  def self.random(num_of_pegs)
    rand_pegs = []
    num_of_pegs.times { rand_pegs << POSSIBLE_PEGS.keys.sample }
    Code.new(rand_pegs)
  end

  def self.from_string(string)
    Code.new(string.chars)
  end

  def initialize(pegs_arr)
    if self.class.valid_pegs?(pegs_arr)
      @pegs = pegs_arr.map(&:upcase)
    else
      raise "pegs invalid"
    end
  end

  def [](position)
    @pegs[position]
  end

  def length
    @pegs.length
  end
end
