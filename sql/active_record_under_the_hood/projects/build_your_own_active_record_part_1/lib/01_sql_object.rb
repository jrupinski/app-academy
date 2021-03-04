require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # execute2 works the same as execute, but returns an array of column names as first row
    # ALSO - interpolation does not work in FROM statemenets, that's why I string interpolated
    # used ||= to keep column names saved, resulting in requiring to run only one query 
    @column_names ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT
        0
    SQL
    .first
    .map(&:to_sym)
  end

  def self.finalize!
  end

  # setter method for table_name instance variable
  def self.table_name=(table_name)
    return nil if table_name.blank?
    @table_name = table_name
  end

  # define/read table_name instance variable
  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
