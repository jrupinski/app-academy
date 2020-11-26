# == Schema Information
#
# Table name: toys
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dog_id     :integer          not null
#  color      :string           not null
#
class Toy < ApplicationRecord

  belongs_to :dog,
    primary_key: :id,  # Dog's id
    foreign_key: :dog_id,  # Toy's id
    class_name: :Dog
end
