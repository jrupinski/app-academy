require_relative "questions_database"

# gem for converting class names to table names
require 'active_support/inflector'

class ModelBase

  # convert class to a table name
  def self.table
    self.to_s.tableize
  end

  # Find row by row id
  def self.find_by_id(id)
    data = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        #{table}
      WHERE
        id = ?;
    SQL

    self.new(data)
  end

  # Return all rows in a table
  def self.all
    data = QuestionsDatabase.execute("SELECT * FROM #{table};")
    data.map { |datum| self.new(datum) }
  end
end