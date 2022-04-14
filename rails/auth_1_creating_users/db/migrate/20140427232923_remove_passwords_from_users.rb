class RemovePasswordsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password, :string
    add_column :users, :password_digest, :string, null: false
    add_index :users, :password_digest, unique: true
  end
end
