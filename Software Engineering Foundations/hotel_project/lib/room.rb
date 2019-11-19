class Room
  def initialize(capacity_num)
    @capacity = capacity_num
    @occupants = []
  end

  attr_accessor :capacity, :occupants

  def full?
    @occupants.count == @capacity
  end

  def available_space
    @capacity - @occupants.count
  end

  def add_occupant(occupant)
    return false if self.full?
  
    occupants << occupant
    true
  end
  
end
