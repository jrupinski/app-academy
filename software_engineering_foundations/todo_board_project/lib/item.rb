class Item
  class InvalidDateError < StandardError; end

  def initialize
    # TODO
  end

  def self.valid_date?(date)
    date_separated = date.split("-")
    if date_separated.count != 3
      puts "wrong date input"
      return false 
    end

    year = date_separated.first.to_i
    month = date_separated[1].to_i
    day = date_separated.last.to_i

    if year < 0
      # raise InvalidDateError
      puts "invalid year" 
    elsif month < 1 || month > 12
      # raise InvalidDateError
      puts "invalid month"
      return false
    elsif day < 1 || day > 31
      # raise InvalidDateError
      puts "invalid day"
      return false
    end

    true
  end
end