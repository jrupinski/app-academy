require "colorize"

class Simon
  require "byebug"
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @seq = []
    @sequence_length = 1
    @game_over = false 
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    system "clear"
    require_sequence

    unless game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    puts "Repeat following combination:"
    @sequence_length.times do |idx|
      system "clear"
      add_random_color
      added_color = @seq[idx]
      print_color(added_color)
      sleep 1.5
    end
  end

  def require_sequence
    puts "Please repeated the combination, step by step:"

    sequence_length.times do |idx|
      current_color = seq[idx]
      print ">"
      input = gets.chomp
      system "clear"
      print_color(input)

      if input != current_color
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "You won this round!"
    sleep 2
  end

  def game_over_message
    puts "Round failed! Game Over!"
    sleep 2
  end

  def reset_game
    @seq.clear
    @sequence_length = 1
    @game_over = false
  end

  def print_color(color_name)
    puts color_name.colorize(color_name.to_sym)
  end
end


if $PROGRAM_NAME == __FILE__
  simon = Simon.new
  simon.play
end