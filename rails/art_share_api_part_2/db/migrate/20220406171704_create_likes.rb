class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :likeable, polymorphic: true
      t.index %i[user_id likeable_id likeable_type], unique: true
      t.timestamps
    end
  end
end
