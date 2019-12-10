#
# Player class for Tic Tac Toe game
#
class HumanPlayer
  def initialize(mark_value)
    @mark_value = mark_value
  end

  def get_position
    p "Enter x coordinate: "
    x = gets.chomp
    p "Enter y coordinate: "
    y = gets.chomp
    
    until x.numbers_only? && y.numbers_only?
      raise "only numbers please" if !x.numbers_only || !y.numbers_only
      p "Enter x coordinate: "
      x = gets.chomp
      p "Enter y coordinate: "
      y = gets.chomp
    end

    [x.to_i, y.to_i]
  end
end


#
# Monkey patch for checking if a string is all numbers
#
class String
  def numbers_only?
    numbers = "0123456789"
    self.each_char.all? { |char| numbers.include?(char) }
  end
end