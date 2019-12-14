require_relative "./HumanPlayer.rb"

#
# Computer Player class for Tic Tac Toe v3
# It gets it's methods from HumanPlayer, but it's positions are taken from an 
# Array of valid (still empty) places on board. 
#
class ComputerPlayer < HumanPlayer  
  def get_position(legal_positions)
    legal_positions.sample
  end
end