class RemoveQuestionAndUserIdFromRating < ActiveRecord::Migration
  def up
    remove_column :ratings, :question_id
    remove_column :ratings, :user_id
    add_column :ratings, :user_question_feedback_id, :integer
  end

  def down
    remove_column :ratings, :user_question_feedback_id
    add_column :ratings, :question_id, :integer
    add_column :ratings, :user_id, :integer
  end
end
