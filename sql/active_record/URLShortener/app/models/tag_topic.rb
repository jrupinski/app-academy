# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord
  validates :name, presence: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: :Tagging

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

  # returns the 5 most visited links for that TagTopic along with the number of times each link has been clicked.
  # I did read the solution to learn about SQL queries through rails instead of using ruby code
  def popular_links
    shortened_urls.joins(:visits)
      .group(:short_url, :long_url)
      .order('COUNT(visits.id) DESC')
      .select('long_url, short_url, COUNT(visits.id) AS number_of_clicks')
      .limit(5)
  end
end
