class UpdateQuestion < ActiveRecord::Migration
  def up
    add_column :questions, :title, :string
    add_column :questions, :category, :string
    add_column :questions, :created_by, :integer
    add_column :questions, :expert_answer, :text    
  end

  def down
    remove_column :questions, :title
    remove_column :questions, :category
    remove_column :questions, :created_by
    remove_column :questions, :expert_answer
  end
end
