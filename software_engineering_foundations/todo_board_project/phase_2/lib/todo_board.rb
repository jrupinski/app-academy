require_relative "./list"
require "byebug"
#
# Todo Board, which contains multiple lists of items
#
class TodoBoard

  def initialize
    @lists = {}
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
    when "mklist"
      raise "Wrong num of arguments" if args.count != 1
      label = args[0]
      raise "List #{label} already exists!" if @lists.has_key?(label.to_sym)
      @lists[label.to_sym] = List.new(label)
      puts "List #{label} created!"
    when "ls"
      puts "Available lists:"
      puts @lists.keys
    when "showall"
      @lists.values.each { |list| puts list.print }
    when "mktodo"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      title = args[1] || nil
      deadline = args[2] || nil
      raise "invalid title or deadline" if title.nil? || deadline.nil?
      description = args[3..-1].join(" ") || ""
      @lists[list_label.to_sym].add_item(title, deadline, description)
      puts "item added!"
    when "toggle"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      index = args[1] || nil
      raise "invalid item index" if index.nil?
      @lists[list_label.to_sym].toggle_item(index.to_i)
      puts "Done status toggled!"
    when "rm"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      index = args[1] || nil
      raise "Valid Item index required" if index.nil?
      @lists[list_label.to_sym].remove_item(index.to_i)
      puts "deleted item!"
    when "purge"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      @lists[list_label.to_sym].purge
      puts "list #{list_label} purged!"
    when "up"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      index = args[1] || nil
      amount = args[1] || 1
      raise "Valid Item index required" if index.nil?
      @lists[list_label.to_sym].up(index.to_i, amount.to_i)
      puts "moved item up by #{amount}"
    when "down"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      index = args[1] || nil
      raise "Valid Item index required" if index.nil?
      amount = args[2] || 1
      @lists[list_label.to_sym].down(index.to_i, amount.to_i)
      puts "moved item down by #{amount}"
    when "swap"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      item_1 = args[0] || nil
      item_2 = args[1] || nil
      raise "Two item indexes required." if item_1.nil? || item_2.nil?
      @lists[list_label.to_sym].swap(item_1.to_i, item_2.to_i)
      puts "items swapped!"
    when "sort"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      @lists[list_label.to_sym].sort_by_date!
      puts "Items sorted!"
    when "priority"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      @lists[list_label.to_sym].print_priority
    when "print"
      list_label = args[0] || nil
      raise "wrong list label" if list_label.nil? || !@lists.has_key?(list_label.to_sym)
      item_idx = args[0]
      item_idx.nil? ? @lists[list_label.to_sym].print : @lists[list_label.to_sym].print_full_item(item_idx.to_i)
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
