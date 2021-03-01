class AttrAccessorObject
  # Implement ::attr_accessor
  def self.my_attr_accessor(*names)
    names.each do |name|
      # custom getter
      define_method(name) { self.instance_variable_get("@#{name}")}
      # custom setter
      define_method("#{name}=") do |value|
        self.instance_variable_set("@#{name}", value)
      end
    end
  end
end
