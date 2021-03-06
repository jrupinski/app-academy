require_relative "questions_database"
require "byebug"

# gem for converting class names to table names
require 'active_support/inflector'

class ModelBase

  # convert class to a table name
  def self.table
    self.to_s.tableize
  end

  # allows users to find records with any number of arguments
  # eg. Reply.find_by(question_id: 2, author_id: 1)
  def self.find_by(arguments)
    self.where(arguments)
  end

  # Accepts an options hash as an argument and searches the database for records 
  # whose column matches the options key and whose value matches the options value. 
  # Now also accepts a String as a direct query 
  def self.where(options)
    if options.is_a?(String)
      query = options
    elsif options.is_a?(Hash)
      attrs = options.keys
      values = options.values
      column_names = attrs.join(", ")
      query = attrs.map { |attr| "#{attr} = ?" }.join(" AND ")
    else
      raise "invalid argument. Only a hash or a direct SQL query string allowed"
    end

    data = QuestionsDatabase.execute(<<-SQL, *values)
      SELECT
        *
      FROM
        #{table}
      WHERE
        #{query};
    SQL

    return nil if data.nil? || data.empty?
    data.map { |datum| self.new(datum) }
  end

  def attributes
    params_array = instance_variables.map do |name|
      [name.to_s[1..-1], instance_variable_get(name)]
    end

    Hash[params_array]
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

    return nil if data.nil?
    self.new(data)
  end

  # Return all rows in a table
  def self.all
    data = QuestionsDatabase.execute("SELECT * FROM #{table};")

    return nil if data.nil?
    data.map { |datum| self.new(datum) }
  end

  # if ID exists in DB - update, else create new 
  def save
    self.id ? update : create
  end

  def create
    instance_attrs = self.attributes
    instance_attrs.delete("id")
    column_names = instance_attrs.keys.join(", ")
    question_marks = (["?"] * instance_attrs.count).join(", ")
    values = instance_attrs.values
    
    # If record doesn't exists - create it
    raise "already saved!" unless id.nil?

    QuestionsDatabase.execute(<<-SQL, *values)
      INSERT INTO
        #{self.class.table} (#{column_names})
      VALUES
        (#{question_marks}); 
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self.class} not found in database, cannot update!" if id.nil?
  
    instance_attrs = self.attributes
    instance_attrs.delete("id")
    column_names = instance_attrs.keys.join(", ")
    set_attr = instance_attrs.keys.map { |attr| "#{attr} = ?" }.join(", ")
    values = instance_attrs.values
    
    QuestionsDatabase.execute(<<-SQL, *values, self.id)
      UPDATE
        #{self.class.table}
      SET
        #{set_attr}
      WHERE
        id = ?;
    SQL

    self
  end
end