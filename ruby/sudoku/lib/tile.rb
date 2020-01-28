require 'colorize'

class Tile
  def initialize(value, given = true)
    @value = value
    @given = given
  end

  def to_s
    tile_given? ? @value.to_s.colorize(:red) : @value.to_s.colorize(:blue)
  end
  
  def value=(number)
    tile_given? ? @value = number : false
  end

  private

  def tile_given?
    @given
  end
end