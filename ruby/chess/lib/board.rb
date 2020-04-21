require_relative "pieces"

require "byebug"
#
# Board for the game Chess
#
class Board
  attr_reader :rows

  def initialize
    # initialize board with placeholder pieces for now
    @sentinel = NullPiece.instance
    populate_chessboard
  end

  #
  # Move Piece across the Chess Board
  #
  # @param [Array] start_pos Starting position of Piece
  # @param [Array] end_pos Ending position of Piece
  #
  
  def move_piece(player_color, start_pos, end_pos)
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
    if piece.is_a?(NullPiece)
      self[pos] = sentinel
    else
      self[pos] = piece.new(pos, self, color_at(pos))
    end
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
    pieces = []
    (0...8).each do |row|
      (0...8).each do |col|
        pos = row, col
        next if self[pos].empty?

        piece = self[pos]
        pieces << piece
      end
    end

    pieces
  end

  def dup
    duped_board = Board.new
    (0...8).each do |row|
      (0...8).each do |col|
        pos = row, col
        og_piece = self[pos]

        if og_piece.is_a?(NullPiece)
          duped_board[pos] = sentinel
        else
          duped_piece = og_piece.class.new(og_piece.pos, duped_board, og_piece.color)
          duped_board[pos] = duped_piece
        end
      end
    end

    duped_board
  end

  private

  attr_reader :sentinel

  #
  # Create a Chessboard and put pieces on it
  #
  # @return [Array] A 2-d Array with Pieces on it - a Chessboard
  #
  def populate_chessboard
    @rows = Array.new(8) { Array.new(8) }

    (0...8).each do |row|
      (0...8).each do |col|
        pos = [row, col]
        piece = piece_at(pos)
        add_piece(piece, pos)
      end
    end
  end

  #
  # Check which Piece should be put on given position when initializing ChessBoard
  #
  # @param [Array] pos Position to check
  #
  # @return [Piece] Piece appropriate for position (Rook/Queen/Knight/King/Bishop/Pawn/Null)
  #
  def piece_at(pos)
    row, col = pos
    if row == 1 || row == 6
      return Pawn
    elsif row != 0 && row !=7 
      return sentinel
    end

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