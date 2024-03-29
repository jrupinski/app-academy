class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.index :username, unique: true
      t.index :session_token, unique: true

      t.timestamps
    end
  end
end
