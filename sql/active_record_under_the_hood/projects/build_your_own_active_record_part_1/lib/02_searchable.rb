require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  #
  # Custom made ActiveDirectory-like ::where to search for rows by given criteria 
  #
  # @param [Hash] params attributes and values to search for in model's table
  #
  # @return [self] Return Child's Class type objects
  #
  def where(params)
    columns = params.keys.map(&:to_s)
    values = params.values

    where_line = columns
      .map { |col| "#{col} = ?" }
      .join(' AND ')

    results = DBConnection.execute(<<-SQL, *values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
