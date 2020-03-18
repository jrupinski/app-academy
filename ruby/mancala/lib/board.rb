class Board
  STORE_CUPS = [6, 13].freeze
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { [] }
    place_stones
  end

  # helper method to #initialize every non-store cup with four stones each
  def place_stones
    cups.each_with_index do |cup, cup_idx|
      4.times { cup << :stone } unless STORE_CUPS.include?(cup_idx) 
    end
  end

  def valid_move?(start_pos)
    if !start_pos.between?(0, cups.count) || STORE_CUPS.include?(start_pos) 
      raise "Invalid starting cup"
    elsif cups[start_pos].empty?
      raise "Starting cup is empty"
    end

    true
  end

  def make_move(start_pos, current_player_name)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
