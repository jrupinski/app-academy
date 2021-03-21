require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  # return columns (as symbols), in an Array.
  def self.columns
    # execute2 works the same as execute, but returns an array of column names as first row
    # ALSO - interpolation does not work in FROM statemenets, that's why I string interpolated
    # used ||= to keep column names saved, resulting in requiring to run only one query 
    @column_names ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
    SQL
    .first
    .map(&:to_sym)
  end

  # Create a getter and setter method for each column, just like my_attr_accessor. 
  # But this time, instead of dynamically creating an instance variable, store everything in the #attributes hash.
  def self.finalize!
    self.columns.each do |column|
      define_method(column) { attributes[column] }
      define_method("#{column}=") { |value| attributes[column] = value }
    end
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

  #
  # Returns all rows in current table
  #
  # @return [Array] Array of current table rows, as model's objects
  #
  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(results)
  end

  #
  # Convert Array of Hashes with table rows into current model's objects 
  #
  # @param [Array] results Array of hashes with each objects' parameters
  #
  # @return [Array] Array of class objects
  #
  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  #
  # Return single record with given ID from table. Return nil if not found.
  #
  # @param [Integer] id ID of table record to find
  #
  # @return [SQLObject] Single SQLObject with given ID
  #
  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        ID = ?
      LIMIT
        1
    SQL

    # using splay operator to remove object Hash from inside Array
    result.empty? ? nil : self.new(*result)
  end

  #
  # Initialize subclass with getters and setters for given parameters
  #
  # @param [Hash] params Hash with table attributes
  #
  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name)
      self.send("#{attr_name}=", value) 
    end
  end

  # Lazily assign a new empty hash if attributes are not initialized yet 
  def attributes
    @attributes ||= Hash.new
  end

  #
  # Returns values of Object's columns rows
  #
  # @return [Array] Array of values
  #
  def attribute_values
    columns = self.class.columns
    columns.map do |column|
      self.send(column)
    end
  end

  #
  # Insert current Object into database's table
  #
  # @return [nil] Nothing
  #
  def insert
    # drop first column - we do not insert row ID
    table_name = self.class.table_name
    columns = self.class.columns.drop(1)
    question_marks = Array.new(columns.count, '?').join(', ')
    column_names = columns
      .map(&:to_s)
      .join(', ')

    # drop first column - we do not insert row ID
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{table_name} (#{column_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  #
  # Update current row in database's table
  #
  # @return [nil] No return value
  #
  def update
    # I know, I should DRY it up - but it's just an exercise, so I'm not gonna add / modify methods
    # because I want the tests to pass. Besides - I'm reinventing the wheel here :) 
    # drop first column - we do not insert row ID
    # debugger
    table_name = self.class.table_name
    columns = self.class.columns


    # Create a sql query with placeholder values ('?')
    set_line = columns
    .map { |attr_name| "#{attr_name} = ?" }
    .join(', ')

    # insert set_line query, each will get the value from attribute_values
    DBConnection.execute(<<-SQL, *attribute_values, id)
    UPDATE
      #{table_name}
    SET
      #{set_line}
    WHERE
      #{table_name}.id = ?
    SQL
  end

  #
  # Save record into the database table.
  # If row exists - update it. If it doesn't - insert it
  #
  # @return [Nil] Nothing
  #
  def save
    id.nil? ? insert : update
  end
end
