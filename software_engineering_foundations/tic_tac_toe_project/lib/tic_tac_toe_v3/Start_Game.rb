require_relative "./Game.rb"

puts "Welcome to Tic Tac Toe!"
print "Please enter board size (it's square so one number, 3 minimum): "
board_size = gets.chomp.to_i
raise "Wrong board size input, exiting..." if board_size < 3
puts "Selected board size: #{board_size}."

puts "Now it's time to create 2 or more players, each with own mark."
puts "input \"done\" if all players are created."

players = {}
loop do
  mark = ""
  player_type = ""

  print "Enter player mark (single char, \"_\" is restricted): "
  input = gets.chomp
  break if input.downcase == "done"
  raise "incorrect mark length" if input.length != 1
  mark = input.to_sym
  puts "Mark: #{mark}."

  print "If this player is human, input \"human\", else AI player will be assigned:"
  input = gets.chomp
  break if input.downcase == "done"
  input.downcase == "human" ? player_type = "human" : player_type = "ai"

  players[mark] = player_type
end

puts
puts "Players created!"
puts "Num of human players: #{players.values.count { |player| player == "human" }}"
puts "Num of ai players: #{players.values.count { |player| player == "ai" }}"
puts
puts "Game start!"
game = Game.new(board_size, players)
game.play