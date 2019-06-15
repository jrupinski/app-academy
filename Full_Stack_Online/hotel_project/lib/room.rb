class Room
  def initialize(capacity)
    @capacity = capacity
    @occupants = []
  end

  def capacity
    @capacity
  end

  def occupants
    @occupants
  end

  def full?
    if @occupants.count == @capacity
      return true
    else
      return false
    end
  end

  def available_space
    @capacity - @occupants.count
  end

  def add_occupant(occupant_name)
    if self.full?
      return false
    else
      @occupants << occupant_name
      return true
    end
  end
end
