class RemoveOldCommentTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :goal_comments
    drop_table :user_comments
  end
end
