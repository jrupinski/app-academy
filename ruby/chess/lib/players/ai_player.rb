class AiPlayer < Player

  def make_move
    if possible_attacks.empty?
      start_pos, end_pos = move_random_piece
    else
      start_pos, end_pos = attack_enemy
    end

    piece = board[start_pos].symbol
    puts "#{color} player: Moving #{piece} at #{start_pos} to #{end_pos}"
    sleep 2

    [start_pos, end_pos]
  end
  
  private
  attr_reader :board
  
  #
  # Lists available player pieces
  #
  # @return [Array] Array of Piece objects
  #
  def available_pieces
    @board = self.display.cursor.board
    board.pieces.select { |piece| piece.color == self.color }
  end

  #
  # Lists all Pieces that can be moved in this turn
  #
  # @return [Array] Array of Piece objects
  #
  def movable_pieces
    available_pieces.reject { |piece| piece.valid_moves.empty? }
  end

  #
  # Lists all possible moves on the board by the player
  #
  # @return [Hash] Hash of piece's start pos and it's possible end positions
  #
  def all_moves
    moves = {}
    movable_pieces.each { |piece| moves[piece.pos] = piece.valid_moves }
    moves
  end

  #
  # Lists all possible moves that will attack the enemy
  #
  # @return [Hash] Hash of Start pos and end pos of each Piece
  #
  def possible_attacks
    attacks = {}
    all_moves.each do |start_pos, moves|
      attacks[start_pos] = moves.reject { |end_pos| board[end_pos].empty? }
    end
    attacks.reject { |k, v| v.empty? }
  end

  #
  # Lists all possible moves on empty board positions
  #
  # @return [Hash] Hash of start and end pos
  #
  def possible_empty_spaces
    empty_spaces = {}
    all_moves.each do |start_pos, moves|
      empty_spaces[start_pos] = moves.select { |end_pos| board[end_pos].empty? }
    end
    empty_spaces.reject { |k, v| v.empty? }
  end
  
  #
  # Sorts possible attacks by most valuable enemy piece
  #
  # @return [Array] Array of moves (each start and end pos)
  #
  def sort_possible_attacks
    attack_priority = { king: 1, queen: 2, rook: 3, bishop: 4, knight: 5, pawn: 6 }
    piece_names = { "♚" => :king, "♛" => :queen, "♜" => :rook, "♝" => :bishop, "♞" => :knight, "♟" => :pawn }
    
    attacks_array = to_a(possible_attacks)
    attacks_array.sort_by do |start_pos, end_pos|
      enemy_piece = @board[end_pos]
      piece_name = piece_names[enemy_piece.symbol]
      attack_priority[piece_name]
    end
  end

  #
  # Attack most valuable enemy piece
  #
  # @return [Array] Start pos and end pos of a piece for attacking
  #
  def attack_enemy
    sort_possible_attacks.first
  end
  
  #
  # Move random piece into an empty place on ChessBoard
  #
  # @return [Array] start and end pos of Piece to move
  #
  def move_random_piece
    to_a(possible_empty_spaces).sample
  end
  
  #
  # Converts Hash of attacks(start positions and it's possible end positions) to an array
  # Each array is a pair of start and end position
  #
  # @param [Hash] attacks_hash Hash of start pos and it's end positions
  #
  # @return [Array] Pairs of start and end positions
  #
  def to_a(attacks_hash)
    array = []
    attacks_hash.each do |start_pos, end_positions_arr|
      end_positions_arr.each do |end_pos|
        array << [start_pos, end_pos]
      end
    end

    array
  end
end