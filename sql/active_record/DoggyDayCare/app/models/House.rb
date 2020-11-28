# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class House < ApplicationRecord
  
  has_many :dogs,
    primary_key: :id,  # House's id
    foreign_key: :house_id,
    class_name: :Dog

  # long way
  # def toys
  #   toys = []
    
  #   dogs.each do |dog|
  #     toys << dog.toys
  #   end

  #   toys
  # end

  has_many :toys,
    through: :dogs,  # house association
    source: :toys  # dogs association

end
