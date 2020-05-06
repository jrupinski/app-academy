  def my_uniq(array)
    uniq = Array.new
    array.each do |ele|
      next if uniq.include?(ele)
      uniq << ele
    end

    uniq
  end