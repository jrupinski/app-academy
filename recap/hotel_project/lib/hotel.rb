require_relative "room"

class Hotel
  def initialize(name, rooms)
    @name = name
    @rooms = {}
    rooms.each { |name, capacity| @rooms[name] = Room.new(capacity) }
  end

  attr_accessor :rooms

  def name
    @name.split.map(&:capitalize).join(" ")
  end

  def room_exists?(room_name)
    rooms.keys.include?(room_name)
  end

  def check_in(guest, room_name)
    if !self.room_exists?(room_name)
      puts "sorry, room does not exist"
      return false
    elsif self.rooms[room_name].full?
      puts "sorry, room is full"
      return false
    else
      rooms[room_name].add_occupant(guest)
      puts "Check in successful"
    end
  end

  def has_vacancy?
    @rooms.any? { |room_name, room| !room.full? }
  end

  def list_rooms
    @rooms.each { |room_name, room| puts "#{room_name} - #{room.available_space}" }
  end
end
