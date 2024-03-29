class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :artwork, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
