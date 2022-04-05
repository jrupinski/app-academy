class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :artwork, foreign_key: true, index: true
      t.references :author, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
  end
end
