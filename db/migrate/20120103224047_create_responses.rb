class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :question_id
      t.string :content

      t.timestamps
    end
  end
end
