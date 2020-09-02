require "byebug"
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      self[key.hash % num_buckets] << key 
      @count += 1
      resize! if count >= num_buckets
    end
  end

  def include?(key)
    self[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key.hash % num_buckets].delete(key)
      @count -= 1
      resize! if self.count < (num_buckets * 0.25)
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # add new buckets or remove unnecessary buckets
    new_size = (self.count >= num_buckets ? num_buckets * 2 : num_buckets / 2)
    # don't downsize past default size
    return false if new_size < 8

    elements = @store.flatten
    # create new buckets, reset counter
    @store = Array.new(new_size) { Array.new }
    @count = 0
    elements.each { |el| self.insert(el) }

  end
end
