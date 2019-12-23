# Player class
class Player
  attr_reader :name
  
  class Alert_invalid_guess < StandardError
    def message
      "Guess invalid!"
    end
  end

  def initialize(name)
    @name = name
  end

  def guess
    # todo
  end
end