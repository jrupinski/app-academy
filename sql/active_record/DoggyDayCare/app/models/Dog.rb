# == Schema Information
#
# Table name: dogs
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Dog < ApplicationRecord
    validates :name, presence: true
    validate :check_length

    def check_length
      unless self.name.length >= 4
        errors[:name] << "Name too short, must be 4 or more characters long"
      end
    end

    has_many :toys,
      primary_key: :id,  #Dog's id
      foreign_key: :dog_id,
      class_name: :Toy
end