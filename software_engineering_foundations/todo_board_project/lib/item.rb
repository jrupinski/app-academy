class Item
  class InvalidDateError < StandardError
    def message
      "Invalid date. Correct format: YYYY-MM-DD"
    end
  end

  def initialize(title, deadline, description)
    raise InvalidDateError if !Item.valid_date?(deadline)
    @title = title
    @deadline = deadline
    @description = description
  end

  def self.valid_date?(date)
    date_separated = date.split("-")
    # if wrong date input (not enough/too many date elements)
    return false if date_separated.count != 3

    year = date_separated.first.to_i
    month = date_separated[1].to_i
    day = date_separated.last.to_i
    # if invalid date format
    return false if year < 0 || month < 1 || month > 12 || day < 1 || day > 31
    
    true
  end
end