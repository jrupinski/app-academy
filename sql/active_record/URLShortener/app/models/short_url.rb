class ShortUrl < ApplicationRecord
  validates :short_url, :user_id, presence: true
end