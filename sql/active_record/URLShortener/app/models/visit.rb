# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  shortened_url_id :integer          not null
#  visitor_id       :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Visit < ApplicationRecord
  validates :shortened_url_id, :visitor_id, presence: true
  
  belongs_to :shortened_url

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: :User

  def self.record_visit!(user, shortened_url)
    create(
      visitor_id: user.id,
      shortened_url_id: shortened_url.id
    )
  end
end
