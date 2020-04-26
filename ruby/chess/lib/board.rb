require_relative "pieces"
require "byebug"
#
# Board for the game Chess
#
class Board
  attr_reader :rows

  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
    populate_chessboard(fill_board)
  end

  #
  # Do sanity checks before moving a piece on Chess Board
  #
  # @param [Array] start_pos Starting position of Piece
  # @param [Array] end_pos Ending position of Piece
  #
  
  def move_piece(player_color, start_pos, end_pos, ai_playing = false)
    raise ArgumentError.new("No piece at starting position") if self[start_pos].empty?

    piece = self[start_pos]
    if !piece.moves.include?(end_pos)
      raise "Invalid move for this piece"
    elsif !piece.valid_moves.include?(end_pos)
      raise "Cannot move into a check"
    elsif player_color != piece.color
      raise "You can only move pieces of your own color"
    end

    move_piece!(start_pos, end_pos)
    piece.promote(ai_playing) if piece.is_a?(Pawn) && piece.at_end_row?
  end

  #
  # Move piece on board(no checks)
  #
  # @param [Array] start_pos Piece to move
  # @param [Array] end_pos Position to move Piece to
  #
  # @return [nil] 
  #
  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos] 
    self[start_pos] = sentinel
    # update piece's position
    self[end_pos].pos = end_pos
  end

  def [](pos)
    raise ArgumentError.new("Invalid position!") if !valid_pos?(pos)
    row, col = pos
    rows[row][col]
  end

  def []=(pos, val)
    raise ArgumentError.new("Invalid position!") if !valid_pos?(pos)
    row, col = pos
    rows[row][col] = val
  end 

  #
  # Check if position is in boundaries of the chess board
  #
  # @param [Array] pos Position to check
  #
  # @return [Boolean] True if position is valid
  #
  def valid_pos?(pos)
    pos.all? { |coor| coor < rows.size && coor >= 0 }
  end
  
  def add_piece(piece, pos)
    raise "There is a Piece on this position already!" unless empty?(pos)
    return nil if piece == sentinel
    self[pos] = piece.new(pos, self, color_at(pos))
  end

  #
  # Check if Player is in a checkmate (King in check and there's no move available to defend him)
  #
  # @param [Symbol] color Color of player
  #
  # @return [Boolean] True if King is in a checkmate
  #
  def checkmate?(color)
    friendly_pieces = pieces.select { |piece| piece.color == color }
    in_check?(color) && friendly_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  #
  # Check if given color's King piece is open to attacks
  #
  # @param [Symbol] color Color of player
  #
  # @return [Boolean] Return true if it's under a check
  #
  def in_check?(color)
    king_pos = find_king(color)
    enemies = pieces.select { |piece| piece.color != color }
    enemies.any? { |enemy| enemy.moves.include?(king_pos)}
  end

  #
  # Find King position on Board
  #
  # @param [Symbol] color Color of Player
  #
  # @return [Array] Row and Column of King, empty otherwise
  #
  def find_king(color)
    pieces.select { |piece| piece.symbol == "♚" && piece.color == color }
    .map(&:pos).flatten
  end

  #
  # List all pieces left on board
  #
  # @return [Array] Array of all remaining pieces on Board
  #
  def pieces
    rows.flatten.reject { |piece| piece == sentinel}
  end

  #
  # Create a deep copy of a  Board
  #
  # @return [Board] Duplicated Board
  #
  def dup
    duped_board = Board.new(false)

    self.pieces.each do |piece| 
      pos = piece.pos
      duped_board[pos] = piece.class.new(piece.pos, duped_board, piece.color) 
    end
    
    duped_board
  end

  private

  attr_reader :sentinel

  #
  # Check if given position is empty on ChessBoard
  #
  # @param [Array] pos Position to check
  #
  # @return [Boolean] True if empty, false otherwise
  #
  def empty?(pos)
    self[pos].empty?
  end

  #
  # Create a Chessboard and put pieces on it
  #
  # @return [Array] A 2-d Array with Pieces on it - a Chessboard
  #
  def populate_chessboard(fill_board)
    @rows = Array.new(8) { Array.new(8, sentinel) }
    return unless fill_board

    place_back_rows
    place_pawns
  end

  #
  # Check which Piece should be put on back position when initializing ChessBoard
  #
  # @param [Array] pos Position to check
  #
  # @return [Piece] Piece appropriate for position (Rook/Queen/Knight/King/Bishop/Pawn/Null)
  #
  def piece_at(pos)
    row, col = pos

    case col
    when 0, 7
      Rook
    when 1, 6
      Knight
    when 2, 5
      Bishop
    when 3
      Queen
    when 4
      King
    end
  end

  #
  # Place Pawns on Chessboard
  #
  # @return [Nil]
  #
  def place_pawns
    [1, 6].each do |row|
      (0...8).each do |col|
        pos = row, col
        add_piece(Pawn, pos)
      end
    end
  end

  #
  # Place Knights, Bishops, Kings and Queens on Chessboard
  #
  # @return [Nil] 
  #
  def place_back_rows
    [0, 7].each do |row|
      (0...8).each do |col|
        pos = row, col
        add_piece(piece_at(pos), pos)
      end
    end
  end

  #
  # Check which color of Piece should be at given position
  #
  # @param [Array] pos Position to check
  #
  # @return [Symbol] Color
  #
  def color_at(pos)
    row, col = pos
    (row == 0 || row == 1) ? :black : :white
  end
end