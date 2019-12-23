# Player class
class Player
  attr_reader :name
  
  class InvalidName < StandardError; end
    
    def initialize(name)
      raise InvalidName if !name.is_a?(String)
      @name = name
    end
    
    def guess
      # todo
    end

    def Alert_invalid_guess 
      # todo
    end
end