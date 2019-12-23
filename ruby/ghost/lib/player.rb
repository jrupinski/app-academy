# Player class
class Player
  attr_reader :name
  
  class InvalidNameError < ArgumentError; end
  
  def initialize(name)
    raise InvalidNameError if !name.is_a?(String)
    @name = name
  end
  
  def guess
    # todo
  end

  def Alert_invalid_guess 
    # todo
  end
end