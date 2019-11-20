require_relative "employee"

class Startup
  attr_reader :name, :salaries, :funding, :employees 

  def initialize(name, funding, salaries)
    @name = name
    @salaries = salaries
    @funding = funding
    @employees = []
  end

  def valid_title?(title)
    @salaries.has_key?(title)
  end

  def >(startup)
    self.funding > startup.funding
  end

  def hire(employee_name, title)
    if valid_title?(title)
      @employees << Employee.new(employee_name, title)
    else
      raise "Title is invalid!"
    end
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    title_salary = @salaries[employee.title]

    if @funding >= title_salary
      employee.pay(title_salary)
      @funding -= title_salary
    else
      raise "Not enough funds to pay employee."
    end
  end

  def payday
    @employees.each { |employee| self.pay_employee(employee) }
  end

  # PART 3 TOMMOROW

  def average_salary
    salary_sum = 0
    @employees.each do |employee|
      title_salary = @salaries[employee.title]
      salary_sum += title_salary
    end

    emp_count = @employees.length
    salary_sum / (emp_count * 1.0)
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(startup)
    # add funding
    @funding += startup.funding
        
    # merging salaries
    # @salaries.merge!(startup.salaries) { |key, v1, v2| v1 }
    startup.salaries.each do |title, amount|
      if !@salaries.has_key?(title)
        @salaries[title] = amount
      end
    end

    # hire employees
    @employees += startup.employees

    # close the other startup
    startup.close
  end
end
