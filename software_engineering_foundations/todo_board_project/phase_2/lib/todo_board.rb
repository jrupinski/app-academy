require_relative "./list"
require "byebug"
#
# Todo Board, which contains multiple list of items
#
class TodoBoard

  def initialize
    @list = Hash.new
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
      puts
      puts File.read("./lib/help.txt")
    when "mktodo"
      title = args[0] || nil
      deadline = args[1] || nil
      raise "invalid title or deadline" if title.nil? || deadline.nil?
      description = args[2..-1].join(" ") || ""
      @list.add_item(title, deadline, description)
    when "toggle"
      index = args[0] || nil
      raise "invalid item index" if index.nil?
      @list.toggle_item(index.to_i)
    when "up"
      index = args[0] || nil
      amount = args[1] || 1
      raise "Valid Item index required" if index.nil?
      @list.up(index.to_i, amount.to_i)
    when "down"
      index = args[0] || nil
      raise "Valid Item index required" if index.nil?
      amount = args[1] || 1
      @list.down(index.to_i, amount.to_i)
    when "swap"
      item_1 = args[0] || nil
      item_2 = args[1] || nil
      raise "Two item indexes required." if item_1.nil? || item_2.nil?
      @list.swap(item_1.to_i, item_2.to_i)
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
      raise "Sorry, command not recognized."
    end

    true
  end

  def run
    loop do
      begin
        while self.get_command; end
      rescue => exception
        puts exception.message
      else
        break
      end
    end
  end
end
