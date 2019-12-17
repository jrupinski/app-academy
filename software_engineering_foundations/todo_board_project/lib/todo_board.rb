require_relative "./list"

#
# Todo Board, which contains a single list of items
#
class Todo_Board

  class InvalidCommandError < StandardError; end

  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    valid_commands = ["mktodo", "up", "down", "swap", "sort", "priority", "print", "quit"]
    puts "Available commands: mktodo, up, down, swap, sort, priority, print, quit"
    print "Enter a command: "
    input = gets.chomp
    raise InvalidCommandError if !valid_commands.include?(input)
    return nil if input == "quit"
    do_command(input)
  end

  def do_command(command)
    # TODO
  end
end
