require_relative "pieces"

require "byebug"
#
# Chess board for chess
#
class Board
  attr_reader :rows

  def initialize
    # initialize board with placeholder pieces for now
    @sentinel = NullPiece.instance
    populate_chessboard
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].empty? || !valid_pos?(start_pos)
      raise ArgumentError.new("No piece at starting position!")
    elsif !self[end_pos].empty? || !valid_pos?(end_pos)
      raise ArgumentError.new("Cannot move to end position!")
    end

    # move piece
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

  def valid_pos?(pos)
    pos.all? { |coor| coor < rows.size && coor >= 0 }
  end
  
  def add_piece(piece, pos)
    if piece == sentinel
      self[pos] = sentinel
    else
      self[pos] = piece.new(pos, self, color_at(pos))
    end
  end

  def checkmate?(color)
    friendly_pieces = pieces.select { |piece| piece.color == color }
    in_check?(color) && friendly_pieces.all?(&:valid_moves.empty?)
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemies = pieces.select { |piece| piece.color != color }
    puts enemies.any? { |enemy| enemy.moves.include?(king_pos)}
  end

  def find_king(color)
    pieces.select { |piece| piece.symbol == "♚" && piece.color == color }
    .map(&:pos).flatten
  end

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

  private

  attr_reader :sentinel

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

  def color_at(pos)
    row, col = pos
    (row == 0 || row == 1) ? :black : :white
  end
end