class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :completed, null: false, default: false
      t.boolean :private, null: false, default: false

      t.references :user, null: false, foreign_key: true
      t.index :title

      t.timestamps
    end
  end
end
