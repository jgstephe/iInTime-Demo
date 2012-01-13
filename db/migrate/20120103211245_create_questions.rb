class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :correct
      t.string :other_a
      t.string :other_b
      t.string :other_c
      t.string :other_d

      t.timestamps
    end
  end
end
