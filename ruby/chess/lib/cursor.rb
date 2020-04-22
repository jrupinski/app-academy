require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

#
# Generate a cursor in terminal output for moving and selecting on chessboard
# Imported from a gist, added @selected, #update_pos and #toggle_selected
#
class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  #
  # Get keyboard input from user
  #
  # @return [nil] Return input to #handle_key method
  #
  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :up
      update_pos(MOVES[:up])
      nil
    when :down
      update_pos(MOVES[:down])
      nil
    when :left
      update_pos(MOVES[:left])
      nil
    when :right
      update_pos(MOVES[:right])
      nil
    when :ctrl_c
      puts "User quit"
      Process.exit(0)
    when :return || :space
      toggle_selected
      return cursor_pos
    end
  end

  #
  # Update cursor position on Board
  # Updates cursor up, down, left or right
  #
  # @param [Array] diff Array of direction where to move (based on MOVES constant)
  #
  # @return [nil] Updates @cursor_pos placement
  #
  def update_pos(diff)
    row, col = cursor_pos
    dx, dy = diff
    new_pos = [row + dx, col + dy]

    @cursor_pos = new_pos unless !board.valid_pos?(new_pos)
  end

  #
  # Toggles if a Piece is selected
  #
  # @return [nil] Updates @selected value
  #
  def toggle_selected
    @selected ? @selected = false : @selected = true
  end
end