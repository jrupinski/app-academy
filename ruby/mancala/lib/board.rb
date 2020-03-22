class Board
  attr_accessor :cups
  require "byebug"

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  # helper method to #initialize every non-store cup with four stones each
  def place_stones
    cups.each_with_index do |cup, cup_idx|
      next if cup_idx == 6 || cup_idx == 13
      4.times { cup << :stone }
    end
  end

  def valid_move?(start_pos)
    if !start_pos.between?(0, cups.count)
      raise "Invalid starting cup"
    elsif cups[start_pos].empty?
      raise "Starting cup is empty"
    end

    true
  end

  def make_move(start_pos, current_player_name)
    # clear cup
    stones_in_hand = cups[start_pos].dup
    cups[start_pos].clear
    
    # distribute stones
    curr_cup_idx = start_pos
    until stones_in_hand.empty?
      curr_cup_idx += 1
      curr_cup_idx = 0 if curr_cup_idx > 13

      # place stones in appropriate cup of current player
      if curr_cup_idx == 6 
        cups[6] << stones_in_hand.pop if current_player_name == @name1
      elsif curr_cup_idx == 13 
        cups[13] << stones_in_hand.pop if current_player_name == @name2
      else
        cups[curr_cup_idx] << stones_in_hand.pop
      end
    end

    self.render
    next_turn(curr_cup_idx)
  end

  # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
    # if ending cup is a store cup - return :prompt to repeat
      :prompt 
    elsif cups[ending_cup_idx].count > 1
    # if turn ends in cup that had stones in it - return ending cup idx to repeat
      ending_cup_idx
    else
    # switch player if ending cup is empty
      :switch
    end
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
