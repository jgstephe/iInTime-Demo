class RemoveQuestionAndUserIdFromResponse < ActiveRecord::Migration
  def up
    remove_column :responses, :question_id
    remove_column :responses, :user_id
    add_column :responses, :user_question_feedback_id, :integer
  end

  def down
    remove_column :responses, :user_question_feedback_id
    add_column :responses, :question_id, :integer
    add_column :responses, :user_id, :integer
  end
end
