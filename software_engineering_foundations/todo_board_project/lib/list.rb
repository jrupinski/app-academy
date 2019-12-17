require_relative "./item"
#
# List of Items for ToDo Board
#
class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  #
  # Add Item to current ToDo List
  #
  # @param [String] title Title of Item
  # @param [String] deadline Deadline of item, in YYYY-MM-DD format
  # @param [String] description Description of item
  #
  # @return [Boolean] Indicate if item was added successfully
  #
  def add_item(title, deadline, description="")
    begin
      new_item = Item.new(title, deadline, description)
    rescue => exception
      puts exception.message
      false
    else
      @items << new_item
      true
    end
  end

  #
  # Get how many items are currently in List
  #
  # @return [Integer] Number of items in current List
  #
  def size
    @items.count
  end

  #
  # Check if Item at given index exists in current List
  #
  # @param [Integer] index Index of Item object
  #
  # @return [Boolean] Indicate if item exists
  #
  def valid_index?(index)
    (0...@items.count).include?(index)
  end

  #
  # Swap places of two items in list at given indexes
  #
  # @param [Integer] index_1 Index of Item to swap
  # @param [Integer] index_2 Index of Item to swap it with
  #
  # @return [Boolean] Return true if swapped successfully, else - false
  #
  def swap(index_1, index_2)
    if valid_index?(index_1) && valid_index?(index_2)
    @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
      true
    else
      false
    end
  end

  #
  # Get item from list at given index
  #
  # @param [Integer] index Index of item
  #
  # @return [Item] return Item object
  #
  def [](index)
    valid_index?(index) ? @items[index] : nil
  end

  #
  # Get first item in list
  #
  # @return [Item] Item object
  #
  def priority
    @items.first
  end

  #
  # Print pretty output for the whole list and all it's items
  #
  # @return [Nil] Return nil
  #
  def print
    puts "------------------------------------------"
    puts "                #{self.label}"
    puts "------------------------------------------"
    puts "Index | Item            | Deadline"
    puts "------------------------------------------"
    @items.each_with_index do |item, idx|
      puts "#{idx.to_s.ljust(5)} | #{item.title.ljust(15)} | #{item.deadline}"
    end
    puts "------------------------------------------"    
  end

  #
  # Print pretty output for item in list at given index
  #
  # @param [Integer] index Index of item
  #
  # @return [Nil] Return nil
  #
  def print_full_item(index)
    return nil if !self.valid_index?(index)
    
    item = self[index]
    puts "------------------------------------------"
    puts "#{item.title.ljust(15)} #{item.deadline}"
    puts "#{item.description}"
    puts "------------------------------------------"
  end

  #
  # Print first element of the list
  #
  # @return [Nil] Don't return anything
  #
  def print_priority
    self.print_full_item(0)
  end

  #
  # Move item up the list
  #
  # @param [Integer] index Index of item to move
  # @param [Integer] amount Amount of indexes to move it up the list
  #
  # @return [Nil] Return nil
  #
  def up(index, amount)
    new_index = index - amount
    return nil if !self.valid_index?(index) || !self.valid_index?(new_index)
    self.swap(index, new_index)
  end

  #
  # Move item down the list
  #
  # @param [Integer] index Index of item to move
  # @param [Integer] amount Amount of indexes to move it down the list
  #
  # @return [Nil] Return nil
  #
  def down(index, amount)
    new_index = index + amount
    return nil if !self.valid_index?(index) || !self.valid_index?(new_index)
    self.swap(index, new_index)
  end

  #
  # Destructively sort List items by date
  #
  # @return [Nil] Return nil
  #
  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
    nil
  end
end