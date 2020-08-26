#
# Basic LRU Cache.
# This will be a simple implementation that doesn't use a hash-map or 
# linked list. We will assume our input is limited to Integers, Strings, 
# Arrays, Symbols,and Hashes. We will allow the user to set the size of 
# the cache. 
#
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
    element_in_cache?(el) ? update_last_usage!(el) : add_element_to_cache(el)
  end

  # shows the items in the cache, starting from the least recently used
  def show
    @cache
  end

  # helper methods go here!
  private

  def element_in_cache?(el)
    @cache.include?(el)
  end

  def update_last_usage!(el)
    @cache.delete(el)
    @cache.push(el)
  end

  def add_element_to_cache(el)
    @cache.shift unless self.count < @capacity
    @cache.push(el)
  end
end