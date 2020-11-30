class ChangeHouseIdNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :people, :house_id, false
  end
end
