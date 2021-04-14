require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  #
  # ActiveRecord-like has_one_through relation method for table records.
  # A belongs-to that goes through an existing belongs-to relation.
  #
  # @param [String] name name of object name/method for relation in object the current object belongs to 
  # @param [String] through_name name of Model current object belongs to, to travel through
  # @param [String] source_name name of Model which current object's model parent belongs to
  #
  # @return [Class] Returns single model object current object has relation with
  #
  def has_one_through(name, through_name, source_name)
    # the source and through options fetching is moved inside define_method
    # Class it belongs to, or Class it goes throgh might not exist when assigning it,
    # causing a crash. This way the class it belongs to has to be called first (so it has to exists first!)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_table = through_options.table_name
      through_fk = through_options.foreign_key
      through_pk = through_options.primary_key

      source_table = source_options.table_name
      source_pk = source_options.primary_key
      source_fk = source_options.foreign_key

      through_fk_val = self.send(through_fk)
      results = DBConnection.execute(<<-SQL, through_fk_val)
        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN 
          #{source_table} 
        ON 
          #{through_table}.#{source_fk} = #{source_table}.#{source_pk}
        WHERE
          #{through_table}.#{through_pk} = ?
      SQL

      source_options.model_class.parse_all(results).first
    end
  end
end
