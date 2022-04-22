class AddUserIdToCats < ActiveRecord::Migration[5.2]
  def change
    add_reference :cats, :user, foreign_key: true, index: true, null: false
  end
end
