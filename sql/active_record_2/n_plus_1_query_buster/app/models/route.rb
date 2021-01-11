# == Schema Information
#
# Table name: routes
#
#  id         :bigint           not null, primary key
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  # Create a hash with bus id's as keys and an array of bus drivers as the corresponding value.
  # (e.g., {'1' => ['Joan Lee', 'Charlie McDonald', 'Kevin Quashie'], '2' => ['Ed Michaels', 'Lisa Frank', 'Sharla Alegria']})
  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
    # 2 + n , so n + 1 SQL queries 
  end

  # Create a hash with bus id's as keys and an array of bus drivers as the corresponding value.
  # (e.g., {'1' => ['Joan Lee', 'Charlie McDonald', 'Kevin Quashie'], '2' => ['Ed Michaels', 'Lisa Frank', 'Sharla Alegria']})
  def better_drivers_query
    buses = self
      .buses
      .select('buses.id, drivers.name AS driver')
      .joins(:drivers)

    all_drivers = Hash.new { |hash, key| hash[key] = [] }

    buses.each do |bus|
      all_drivers[bus.id] << bus.driver
    end

    all_drivers
    # 2 SQL queries total - one into Route, one into Bus
  end
end
