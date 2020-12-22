# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :short_url, :user_id, :long_url, presence: true
  validate :no_spamming, :nonpremium_max

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },  # lambda for returning unique users 
    through: :visits,
    source: :visitor

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic
  
  def self.create_for_user_and_long_url!(user, long_url)
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

  # Allow for creation of 5 ShortenedUrls per minute max
  def no_spamming
    created_urls = submitter.submitted_urls
    num_of_recent_urls = created_urls
      .where('created_at > ?', 1.minute.ago)
      .count

    raise "Cannot create more than 5 shortened links in a minute!" if num_of_recent_urls >= 5 
  end

  # Limit non-premium users to creating 5 ShortenedUrls max
  def nonpremium_max
    return nil if submitter.premium
    created_urls = submitter.submitted_urls
    raise "Non-premium accounts are limited to 5 Shortened URLs per user" if created_urls.count >= 5
  end

  # Delete shortenedUrls that have not been visited in the last (n) minutes
  # TODO: REFACTOR TO A SINGLE QUERY
  def self.prune(n)
    urls_to_remove = []

    self.all.each do |shortened_url|
      last_visit = shortened_url.visits.last
      # debugger
      next if last_visit.nil?
      urls_to_remove << shortened_url.id if last_visit.created_at < n.minutes.ago
    end

    urls_to_remove.each do |shortened_url_id|
      
      ShortenedUrl.find(shortened_url_id).destroy
    end
  end

end
