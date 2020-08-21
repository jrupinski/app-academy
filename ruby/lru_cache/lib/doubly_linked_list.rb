class DoublyLinkedList
  attr_accessor :prev_node, :next_node, :val

  def initialize(val = nil, next_node = nil, prev_node = nil)
    @val = val
    @next_node = next_node
    @prev_node = prev_node
  end
end