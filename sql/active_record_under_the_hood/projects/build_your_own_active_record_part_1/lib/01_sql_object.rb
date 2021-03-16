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
        #{table_name}
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

  def self.find(id)
    # ...
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
