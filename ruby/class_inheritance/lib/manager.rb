require_relative "./employee"

require "byebug"
class Manager < Employee

  attr_accessor :employees

  def initialize(name, title, salary, boss, *employees)
    super(name,title,salary,boss)
    @employees = employees || []
  end

  def bonus(multiplier)
    return salary if !self.is_a?(Manager)
    employees_salaries = employees.sum { |employee| employee.bonus(1) }

    # OH BOY IS THIS HACKY AS HELL
    return salary + employees_salaries if multiplier == 1
    bonus = employees_salaries * multiplier
    
    bonus
  end
end