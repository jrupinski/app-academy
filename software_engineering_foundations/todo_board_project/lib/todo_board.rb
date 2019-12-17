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
    puts "Type help to list all available commands."
    print "Enter a command: "
    input = gets.chomp
    command = input.split.first.downcase
    args = input.split[1..-1]
    do_command(command, *args)
  end

  def do_command(command, *args)
    case command
    when "help"
      puts File.read("./lib/commands.txt")
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
