class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :session_token

      t.index :username, unique: true
      t.index :session_token, unique: true
      t.timestamps
    end
  end
end
