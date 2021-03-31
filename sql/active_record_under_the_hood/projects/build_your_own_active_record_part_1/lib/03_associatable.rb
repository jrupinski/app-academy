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
    self.class_name.constantize
  end

  #
  # Returns current row/object's class/model table name
  #
  # @return [String] table name of current object/child
  #
  def table_name
    self.model_class.table_name
  end
end

#
# Custom made class that holds values for belongs_to association (just like in rails's active directory)
#
class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{name}_id".downcase.to_sym
    @class_name = options[:class_name] || name.camelcase
  end
end

#
# # Custom made class that holds values for has_many association (just like in rails's active directory)
#
class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{self_class_name}_id".downcase.to_sym
    @class_name = options[:class_name] || name.singularize.camelcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
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
end
