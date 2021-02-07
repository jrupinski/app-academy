class ChangeQuestionsColumn < ActiveRecord::Migration[6.1]
  def up
    rename_column :questions, :question, :text
    change_column :questions, :text, :string
  end

  def down
    change_column :questions, :text, :text
    rename_column :questions, :text, :question
  end
end
