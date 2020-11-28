class AddHouseIdToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :house_id, :integer
  end
end
