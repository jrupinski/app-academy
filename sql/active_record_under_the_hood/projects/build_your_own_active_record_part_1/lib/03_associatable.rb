require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  #
  # Fetch object's class/model from class's class_name string
  #
  # @return [Object] Object of class_name 
  #
  def model_class
    class_name.constantize
  end

  #
  # Returns current row/object's class/model table name
  #
  # @return [String] table name of current object/child
  #
  def table_name
    model_class.table_name
  end
end

#
# Custom made class that holds values for belongs_to association (just like in rails's active directory)
#
class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{name.to_s}_id".to_sym
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

#
# # Custom made class that holds values for has_many association (just like in rails's active directory)
# Use String#underscore so CamelCase classes get correctly named as keys
#
class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable
  #
  # custom-made ActiveRecord-like belongs_to association.
  # Uses custom made methods too, that's why #where is using a hash 
  #
  # @param [String] name Name of class association
  # @param [Hash] options Optional hash with non-default key and attribute values
  #
  # @return [Class] Returns single object of association's class
  #
  def belongs_to(name, options = {})
  options = BelongsToOptions.new(name, options)
  define_method(name) do
      fg_key = options.send(:foreign_key)
      fg_key_value = self.send(fg_key)
      model = options.model_class
      # options
      #   .model_class
      #   .where(options.primary_key => fg_key_value)
      #   .first
      
      # refactored method:
      model.find(fg_key_value)
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
