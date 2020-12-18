class AddTimestampsToShortenedUrl < ActiveRecord::Migration[6.0]
  def change
    # Add default value to existing records - date and time of adding this migration
    add_timestamps :shortened_urls, null: false, default: -> { 'NOW()' }
    # add_column :shortened_urls, :created_at, :datetime, null: false
    # add_column :shortened_urls, :updated_at, :datetime, null: false
  end
end
