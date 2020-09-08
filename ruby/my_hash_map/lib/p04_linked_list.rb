require "byebug"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev_node = self.prev
    next_node = self.next
    prev_node.next = next_node
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
  end

  def include?(key)
  self.each { |node| return true if node.key == key }

  false
  end

  def append(key, val)
    last_node = @tail.prev
    new_node = Node.new(key, val)

    new_node.prev = last_node
    new_node.next = @tail

    last_node.next = new_node
    @tail.prev = new_node
  end

  #
  # Find an existing node by key and update its value
  #
  # @param [String, Numeric, Symbol] key Hash key
  # @param [String, Numeric, Symbol] val Hash value
  #
  # @return [Nil] No return value
  #
  def update(key, val)
    self[key].val = val if self.include?(key)
    nil
  end

  def remove(key)
    # This requires each_with_index...
    self[key].remove
  end

  #
  # Enumerate through every node in Linked List
  #
  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node if block_given?
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
