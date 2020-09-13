require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

#
# LRU Cache, using a Linked list and a HashMap.
# max - max elements in Cache
# prc - code block to process every element throught (to calculate value of 
# given key for insertion)
#
class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  #
  # Count of current elements in the Cache
  #
  # @return [Integer] Number of current elements
  #
  def count
    @map.count
  end

  #
  # Insert / update value into cache
  # If node doesn't exist - add it's key and value to a linked list, and to 
  # a Hashmap that points key to it's Node's pointer in Linked List
  # Else update key's value in LinkedList and update it's pointer
  #
  # @param [String, Numerable] key A key to insert into the cache
  #
  # @return [String, Numerable] Return value of key run through a proc
  #
  def get(key)
    if @map.include?(key)
      node = @map[key]
      update_node!(node)
      update_map!(key)
    else
      eject! if count >= @max
      val = calc!(key)
      add_node(key, val)
      update_map!(key)
    end

    # Return the value (value of key run through proc)
    val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  #
  # Calculate Value of given Key for Cache
  #
  # @param [String, Numerable] key Key to calculate value from
  #
  # @return [String, Numerable] Value calculated from the cache
  #
  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  #
  # Add a node to the LinkedList
  #
  # @param [String, Numerable] key Key of Node to append to the LinkedList
  # @param [String, Numerable] val Value of Node to append to the LinkedList
  #
  # @return [Node] Inserted Node object
  #
  def add_node(key, val)
    @store.append(key, val)
  end

  # suggested helper method; move a node to the end of the list
  def update_node!(node)
    @store.remove(node.key)
    @store.append(node.key, node.val)
  end

  # Update pointer of key to point to the updated Node
  def update_map!(key)
    @map.set(key, @store.last)
  end

  # Remove oldest node from the LRUCache
  def eject!
    oldest_object = @store.first
    @map.delete(oldest_object.key)
    @store.remove(oldest_object.key)
  end
end
