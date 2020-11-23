require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("../db/questions.db")
    self.type_translation = true
    self.results_as_hash = true
  end

  # syntactic sugar
  def self.execute(*args)
    self.instance.execute(*args)
  end

  def self.get_first_row(*args)
    self.instance.get_first_row(*args)
  end
  
  def self.get_first_value(*args)
    self.instance.get_first_value(*args)
  end
end