require_relative "./list"
require "byebug"
#
# Todo Board, which contains a single list of items
#
class Todo_Board

  class InvalidCommandError < StandardError; end

  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    puts "Available commands: mktodo, up, down, swap, sort, priority, print, quit"
    print "Enter a command: "
    input = gets.chomp
    command = input.split.first.downcase
    args = input.split[1..-1]
    do_command(command, *args)
  end

  def do_command(command, *args)
    case command
    when "help"
      puts "mktodo <title> <deadline> <optional description>"
      puts "    makes a todo with the given information"
      puts "up <index> <optional amount>"
      puts "    raises the todo up the list"
      puts "down <index> <optional amount>"
      puts "    lowers the todo down the list"
      puts "swap <index_1> <index_2>"
      puts "    swaps the position of todos"
      puts "sort"
      puts "    sorts the todos by date"
      puts "priority"
      puts "    prints the todo at the top of the list"
      puts "print <optional index>"
      puts "    prints all todos if no index is provided"
      puts "    prints full information of the specified todo if an index is provided"
      puts "quit"
      puts "    returns false"
    when "mktodo"
      title = args[0] || nil
      deadline = args[1] || nil
      description = args[2..-1].join(" ") || ""
      raise "invalid title or deadline" if title.nil? || deadline.nil?
      @list.add_item(title, deadline, description)
    when "up"
      index = args[0].to_i || nil
      amount = args[1].to_i || 1
      raise "Valid Item index required" if index.nil?
      @list.up(index, amount)
    when "down"
      index = args[0].to_i || nil
      raise "Valid Item index required" if index.nil?
      amount = args[1].to_i || 1
      @list.down(index, amount)
    when "swap"
      item_1 = args[0].to_i || nil
      item_2 = args[1].to_i || nil
      raise "Two item indexes required." if item_1.nil? || item_2.nil?
      @list.swap(item_1, item_2)
    when "sort"
      @list.sort_by_date!
    when "priority"
      @list.print_priority
    when "print"
      item_idx = args[0]
      item_idx.nil? ? @list.print : @list.print_full_item(item_idx.to_i)
    when "quit"
      puts "Quitting..."
      return nil
    else
      puts "Sorry, command not recognized."
      raise InvalidCommandError
    end

    true
  end
end
