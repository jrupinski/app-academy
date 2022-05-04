class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.boolean :live, null: false, default: false
      t.references :band, null: false, foreign_key: true
      t.index %i[band_id name], unique: true

      t.timestamps
    end
  end
end
