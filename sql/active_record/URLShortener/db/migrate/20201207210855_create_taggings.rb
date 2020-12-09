class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id, null: false
      t.integer :shortened_url_id, null: false
      
      t.timestamps
    end

    # indexes for given tag topic to find shortened url
    # A.K.A. Unique with combination  
    add_index :taggings, [:tag_topic_id, :shortened_url_id], unique: true
    # Regular index 
    add_index :taggings, :shortened_url_id
  end
end
