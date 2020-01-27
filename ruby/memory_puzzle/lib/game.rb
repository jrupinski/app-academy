require_relative "board.rb"
require_relative "human_player.rb"
require_relative "ai_player.rb"

class Game
  def initialize(size = 4)
    @board = Board.new(size)
    @previous_guess = nil
    @players = [AiPlayer.new, AiPlayer.new]
    @current_player = 0
  end

  def play
    generate_board
    until game_over
      2.times do
        render_board
        position = current_player.guess
        make_guess(position)
        clear_terminal
      end

      next_player
    end

    render_board
    puts "GAME OVER!\n #{current_player} WON!"
  end

  private

  def render_board
    @board.render
  end

  def generate_board
    @board.populate
  end

  def game_over
    @board.won?
  end

  def make_guess(position)
    reveal_card(position)
    current_card = position
    update_known_cards(current_card)
    
    if checking_another_card?
      if @board[@previous_guess] == @board[current_card]
        update_matched_cards(@previous_guess, current_card)
      else 
        render_board
        puts "try again"
        sleep 2
        [@previous_guess, current_card].each { |pos| @board[pos].hide }
      end
      
      @previous_guess = nil
    else
      @previous_guess = current_card
    end
  end

  def reveal_card(position)
    @board.reveal(*position)
  end

  def checking_another_card?
    @previous_guess.nil? ? false : true
  end

  def clear_terminal
    system 'clear'
  end

  def update_matched_cards(card_1, card_2)
    @players.each { |player| player.receive_match(card_1, card_2) }
  end
  
  def update_known_cards(position)
    @players.each do |player|
      card_value = @board[position].value
      player.receive_revealed_card(card_value, position)
    end
  end
  
  def current_player
    @players[@current_player]
  end

  def next_player
    @current_player = (@current_player + 1) % @players.count 
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end