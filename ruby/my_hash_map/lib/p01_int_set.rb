require "byebug"

class MaxIntSet
  # added it because it's necessary for passing spec suite
  attr_reader :store
  
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    return false if self.include?(num) 
    @store[num] = true 
  end

  def remove(num)
    validate!(num)
    @store[num] = false if self.include?(num) 
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end
  
  def include?(num)
    self[num].include?(num)
  end

  private

  # optional but useful; return the bucket corresponding to `num`
  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)
    self[num] << num
    resize! if count >= num_buckets
  end

  def remove(num)
    if self.include?(num)
      @count -= 1
      self[num].delete(num)
      resize! if self.count < (num_buckets * 0.25)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def count
    @store.sum(&:count)
  end

  def inspect
    p "num_of_buckets: #{num_buckets}"
    @store
  end
  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # add new buckets or remove unnecessary buckets
    new_size = (self.count >= num_buckets ? num_buckets * 2 : num_buckets / 2)
    # don't downsize past default size
    return false if new_size < 20

    elements = @store.flatten
    @store = Array.new(new_size) { Array.new }
    elements.each { |el| self.insert(el) }
  end
end

