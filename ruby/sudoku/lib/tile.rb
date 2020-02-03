require 'colorize'

class Tile
  def initialize(value)
    @value = value
    @given = value == 0 ? false : true
  end

  def to_s
    tile_given? ? @value.to_s.colorize(:blue) : @value.to_s.colorize(:red)
  end

  def value
    @value
  end
  
  def value=(number)
    if tile_given?
      puts "You cannot change the value of this tile."
    else
      @value = number
    end
  end

  private

  def tile_given?
    @given
  end
end