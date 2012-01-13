class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_question_feedback_id
      t.text :comment

      t.timestamps
    end
  end
end
