# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  short_url :string           not null
#  long_url  :string           not null
#  user_id   :integer
#
class ShortenedUrl < ApplicationRecord
  validates :short_url, :user_id, :long_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },  # lambda for returning unique users 
    through: :visits,
    source: :visitor

  def self.create_for_user_and_url!(user, long_url)
    ShortenedUrl.create!(
      user_id: user.id,
      long_url: long_url,
      short_url: random_code
      )
  end

  def self.random_code
    loop do
      random_code = SecureRandom.urlsafe_base64
      return random_code unless ShortenedUrl.exists?(short_url: random_code)
    end
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    # visits.select(:visitor_id).distinct.count
    # un-distincted version / version without using lambda above
    visitors.count
  end

  def recent_uniques
    visits
      .select(:visitor_id)
      .where('created_at > ?', 10.minutes.from_now)
      .distinct
      .count
  end
end
