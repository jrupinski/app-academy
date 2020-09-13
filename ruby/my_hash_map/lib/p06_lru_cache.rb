require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map[key]
      update_node!(node)
    else
      self.eject! if count >= @max
      val = calc!(key)
      @store.append(key, val)
      @map.set(key, @store.last)
      # according to the spec - get should return the value of proc
      val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @store.append(node.key, node.val)
    @map.set(node.key, @store.last)
  end

  def eject!
    first_node = @store.first
    @map.delete(first_node.key)
    @store.remove(first_node.key)
  end
end
