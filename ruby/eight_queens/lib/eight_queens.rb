require "set"

class EightQueens
  def initialize
    @board = Array.new(8) { Array.new(8, false) }
  end
  
  def find_position
    # TODO
  end

  # private
  attr_reader :board
end
  
# if $PROGRAM_NAME == __FILE__
#   EightQueens.new.find_position
# end