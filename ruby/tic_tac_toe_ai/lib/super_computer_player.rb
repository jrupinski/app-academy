require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  #
  # Hard AI player that only wins or ties.
  # Upgraded ComputerPlayer that only takes winning or non-losing move.
  # Stores possible moves in a Polytree to see one move ahead.
  #
  # @param [Game] game Instance of Tic Tac Toe game
  # @param [Symbol] mark Mark given to AI player
  #
  # @return [Array] Position of next move (winning or non-losing one)
  #
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    possible_moves = current_node.children
    losing_moves = []

    # go to first possible winning node, else collect list of loser nodes
    possible_moves.each do |node|
      return node.prev_move_pos if node.winning_node?(mark)
      losing_moves << node if node.losing_node?(mark)
    end

    possible_moves = possible_moves - losing_moves
    raise "No non-losing moves left!" if possible_moves.empty?

    
    # return random move that isn't a losing one
    possible_moves.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
