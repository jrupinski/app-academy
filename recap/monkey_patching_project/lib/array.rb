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

  # Part 2
  def my_count(value)
    count = 0

    self.each { |ele| count +=1 if ele.eql?(value) }

    count
  end

  def my_index(value)
    return nil if self.empty? || !self.include?(value)

    self.each.with_index { |ele, idx| return idx if ele.eql?(value) }
  end

  def my_uniq
    no_dupl = []

    self.each { |ele| no_dupl << ele if !no_dupl.include?(ele) }

    no_dupl
  end

  def my_transpose
    result = []

    self.each_with_index do |row, row_idx|
      
      trans_row = []
      row.each_with_index do |col, col_idx|
        trans_row << self[col_idx][row_idx]
      end

      result << trans_row
    end

    result
  end
end
