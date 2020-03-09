#
# Create polytree Tree with n branch childen.
#

require "byebug"

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value 
    @parent = nil
    @children = []
  end

  #
  # Change parent node. Add node to their parent's children and set it as new parent.
  #
  # @param [node] node new node
  #
  # @return [node] new parent node
  #
  def parent=(node)
    parent.children.delete(self) unless parent.nil?
    @parent = node
    parent.children << self unless parent.nil? || parent.children.include?(self) 
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent.nil? ? (raise "Node is not a child!") : child_node.parent = nil
  end

  
end