require_relative "doubly_linked_list"
require "byebug"

class LRUCache

  attr_reader :head, :tail

  def initialize
    @head = DoublyLinkedList.new
    @tail = DoublyLinkedList.new
    @head.prev_node = @tail
    @tail.next_node = @head
  end

  def print
    current_node = @tail.next_node
    values = []
    until current_node.next_node == nil
      values << current_node.val
      current_node = current_node.next_node
    end

    p values
  end

  def remove(val)
    current_node = @tail
    until current_node.val == val
      current_node = current_node.next_node
    end

    remove_node(current_node) unless current_node == @head
  end


  def add_node(new_node)
    prev_node = @head.prev_node
    prev_node.next_node = new_node
    new_node.prev_node = prev_node
    new_node.next_node = @head
    @head.prev_node = new_node
  end

  def remove_node(node)
    debugger
    next_node = node.next_node
    prev_node = node.prev_node
    next_node.prev_node = node.prev_node
    prev_node.prev_node = next_node

  end




end