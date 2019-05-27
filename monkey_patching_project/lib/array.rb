require "byebug"

# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  # PART 1
  def span
    if self.empty?
      return nil
    end
    # check if every element is an integer, then return diff between max and min
    self.each { |ele| return nil if !ele.integer? }
    self.max - self.min
  end

  def average
    return nil if self.empty?
    (self.sum).to_f / self.count
  end

  def median
    return nil if self.empty?

    sorted = self.sort
    if sorted.count.even?
      mid_ele_1 = sorted[sorted.count/2]
      mid_ele_2 = sorted[(sorted.count/2)-1]
      # debugger
      return (mid_ele_1 + mid_ele_2).to_f / 2
    else
      return sorted[sorted.count/2]
    end
  end

  def counts
    count = Hash.new(0)
    self.each { |ele| count[ele] += 1 }
    count
  end

  # PART 2
  def my_count(value)
    count = 0
    self.each { |ele| count += 1 if ele == value }
    count
  end

  def my_index(value)
    self.each_with_index { |ele, i| return i if ele == value }

    nil
  end

  def my_uniq
    # unique = []
    # self.each { |ele| unique << ele if !unique.include?(ele) }
    # unique
    unique = {}
    self.each { |ele| unique[ele] = true }
    unique.keys
  end

  def my_transpose
    result = []

    (0...self.length).each do |row|
      new_row = []

      (0...self.length).each do |col|
        new_row << self[col][row]
      end

      result << new_row
    end
    
    result
  end
end