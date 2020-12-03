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

  has_many :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

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
end
