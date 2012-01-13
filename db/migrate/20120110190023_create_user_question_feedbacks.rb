class CreateUserQuestionFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_question_feedbacks do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
    
    add_index :user_question_feedbacks, :user_id
    add_index :user_question_feedbacks, :question_id
    add_index :user_question_feedbacks, [:user_id, :question_id], :unique => true
  end
end
