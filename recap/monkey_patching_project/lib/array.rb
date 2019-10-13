# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  # PART 1
  def span
    return nil if self.empty?
    self.max - self.min
  end

  def average
    return nil if self.empty? || self.none? { |ele| ele.instance_of?(Integer) }
    self.sum / (self.count * 1.0)
  end

  def median
    return nil if self.empty?

    sorted = self.sort

    if self.count.odd?
      sorted[self.count / 2]
    else
      mid_ele_left = sorted[(self.count / 2) - 1]
      mid_ele_right = sorted[self.count / 2]
      [mid_ele_left, mid_ele_right].average
    end
  end

  def counts
    ele_count = Hash.new(0)

    self.each { |ele| ele_count[ele] += 1 }

    ele_count
  end
end
