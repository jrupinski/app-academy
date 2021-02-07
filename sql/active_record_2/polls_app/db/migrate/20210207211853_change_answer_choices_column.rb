class ChangeAnswerChoicesColumn < ActiveRecord::Migration[6.1]
  def up
    change_column :answer_choices, :text, :string
  end
  
  def down
    change_column :answer_choices, :text, :text
  end
end
