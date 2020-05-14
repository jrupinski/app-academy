class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = Array.new(3) { [] } 
    @towers[0] += [3, 2, 1]
  end

  def play
    system "clear"
    until won?
      print_towers
      move_disc
    end

    system "clear"
    puts "GAME OVER!"
  end

  def move(start_tower, end_tower)
    raise IndexError, "Invalid index of towers" unless [start_tower, end_tower].all? { |arg| arg.between?(0, towers.count - 1) }
    raise ArgumentError, "Starting tower is empty!" if towers[start_tower].empty?
    unless towers[end_tower].empty?
      raise ArgumentError, "Cannot put bigger disk on a smaller one!" if towers[start_tower].last > towers[end_tower].last
    end

    move!(start_tower, end_tower)
  end
  
  def won?
    towers.last == [3, 2, 1] && towers[0..1].all?(&:empty?)
  end

  private

  def move_disc
    begin
      start_tower, end_tower = user_input
      move(start_tower, end_tower)
    rescue => exception
      puts "#{exception.message}. Try Again!"
      sleep 2
      retry
    ensure
      system "clear"
    end
  end

  def user_input
    puts "Enter tower(1, 2 or 3) to take disk from:> "
    start_tower = gets.to_i - 1
    puts "\nEnter tower(1, 2 or 3) to put disk on:> "
    end_tower = gets.to_i - 1

    [start_tower, end_tower]
  end


  def print_towers
    puts "Towers: #{towers[0]} #{towers[1]} #{towers[2]}"
  end

  def move!(start_tower, end_tower)
    @towers[end_tower] << @towers[start_tower].pop
  end
end

if __FILE__ == $PROGRAM_NAME
  game = TowersOfHanoi.new
  game.play
end