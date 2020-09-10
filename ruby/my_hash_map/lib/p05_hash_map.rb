require_relative 'p04_linked_list'

class HashMap
  # include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.include?(key) 
      bucket(key).update(key, val)
    else
      resize! if @count > num_buckets
      bucket(key).append(key, val)
      @count += 1
    end 
  end

  def get(key)
    # if key at appriopriate bucket has the key-val - get it 
    bucket(key).get(key) 
  end

  def delete(key)
    if self.include?(key)
      bucket(key).remove(key)
      @count -= 1
      resize! if @count < (num_buckets * 0.25)
    end
  end

  # TODO: Fix/implement this, and import Enumerable module
  def each(&block)
  #   # debugger
  #   @store.each { |list| list.each { |node| block.call(node) } if block_given? }
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # add new buckets or remove unnecessary buckets
    new_size = (self.count >= num_buckets ? num_buckets * 2 : num_buckets / 2)
    # don't downsize past default size
    return false if new_size < 8

    lists = @store.flatten
    
    elements = Hash.new
    lists.each do |node_head|
      node_head.each { |node| elements[node.key] =  node.val }
    end

    # create new buckets, reset counter
    @store = Array.new(new_size) { LinkedList.new }
    @count = 0
    elements.each { |key, val| self.set(key, val) }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hashed_key = key.hash
    bucket_num = hashed_key % num_buckets
    @store[bucket_num]
  end
end
