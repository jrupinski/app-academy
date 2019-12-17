require_relative "./item"
class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

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

  def size
    @items.count
  end

  def valid_index?(index)
    (0...@items.count).include?(index)
  end

  def swap(index_1, index_2)
    if valid_index?(index_1) && valid_index?(index_2)
    @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
      true
    else
      false
    end
  end

  def [](index)
    valid_index?(index) ? @items[index] : nil
  end

  def priority
    @items.first
  end

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
    nil
  end

  def print_full_item(index)
    return nil if !self.valid_index?(index)
    
    item = self[index]
    puts "------------------------------------------"
    puts "#{item.title.ljust(15)} #{item.deadline}"
    puts "#{item.description}"
    puts "------------------------------------------"
  end

  def print_priority
    self.print_full_item(0)
  end
end