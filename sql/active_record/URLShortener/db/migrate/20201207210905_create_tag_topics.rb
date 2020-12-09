class CreateTagTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_topics do |t|
      t.string :name, null: false
      
      t.timestamps
    end
  end
end
