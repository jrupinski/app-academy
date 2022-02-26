class CreateArtworkShares < ActiveRecord::Migration[6.1]
  def change
    create_table :artwork_shares do |t|
      t.references :viewer, foreign_key: { to_table: :users }, index: true
      t.references :artwork, index: true
      t.timestamps
    end

    add_index :artwork_shares, %i[artwork_id viewer_id], unique: true
  end
end
