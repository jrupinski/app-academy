class FixUserIdColumnNameInVisit < ActiveRecord::Migration[6.0]
  def change
    rename_column :visits, :visitor_id, :user_id
  end
end
