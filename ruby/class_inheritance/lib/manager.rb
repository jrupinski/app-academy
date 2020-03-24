require_relative "./employee"

require "byebug"
class Manager < Employee

  attr_accessor :employees

  def initialize(name, title, salary, boss, *employees)
    super(name,title,salary,boss)
    @employees = employees || []
  end

  def bonus(multiplier)
    debugger
    bonus = employees.sum(&:salary) * multiplier
    bonus
  end
end