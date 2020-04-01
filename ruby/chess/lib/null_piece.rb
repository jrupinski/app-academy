require_relative "piece"
require "singleton"

class NullPiece < Piece
  include Singleton

  attr_reader :symbol, :color
  
  def initialize
    @color = :none
    @symbol = " "
  end

  def moves
    []
  end

  def empty?
    true
  end
end