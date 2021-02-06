class CreatePolls < ActiveRecord::Migration[6.1]
  def change
    create_table :polls do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.timestamps
    end

    add_index :polls, :user_id
  end
end
