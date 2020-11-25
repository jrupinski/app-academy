class Dog < ApplicationRecord
    validates :name, presence: true
    validate :check_length

    def check_length
      unless self.name.length >= 4
        errors[:name] << "Name too short, must be 4 or more characters long"
      end
    end
end