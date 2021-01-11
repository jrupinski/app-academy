# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id,
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  # Create an array of all the seeds within a given house
  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  # Create an array of all the seeds within a given house (non - n+1 query)
  def better_seeds_query
    plants = self
      .plants
      .includes(:seeds)

      seeds = []

      plants.each do |plant|
        seeds << plant.seeds
      end

      seeds
      # 3 queries
  end
end
