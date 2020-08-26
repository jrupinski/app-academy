require "byebug"
class LRUCache
def initialize(capacity = 4)
  @capacity = capacity
  @cache = []
end

# returns number of elements currently in cache
def count
  @cache.count
end

# adds element to cache according to LRU principle
def add(el)
  if @cache.include?(el)
    @cache.delete(el)
    @cache.push(el)
  else
    @cache.shift unless self.count < @capacity
    @cache.push(el)
  end
end

# shows the items in the cache, with the LRU item first
def show
  @cache
end

private
# helper methods go here!

  def current_timestamp
    Time.now.getutc.to_s
  end

  def update_timestamp(item)
    raise ArgumentError unless item.is_a?(Array)
    item[1] = current_timestamp

    item
  end

end