class Flight
  attr_reader :passengers
  
  def initialize(flight_number, capacity)
    @flight_number = flight_number
    @passengers = []
    @capacity = capacity
  end

  def board_passenger(passenger)
    @passengers << passenger if passenger.has_flight?(@flight_number) && !self.full?
  end

  def list_passengers
    self.passengers.map { |passenger| passenger.name }
  end

  def full?
    self.passengers.count >= @capacity
  end

  def [](idx)
    self.passengers[idx]
  end

  def <<(passenger)
    self.board_passenger(passenger)
  end

end