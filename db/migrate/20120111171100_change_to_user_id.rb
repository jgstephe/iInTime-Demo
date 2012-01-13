class ChangeToUserId < ActiveRecord::Migration
  def up
    remove_column :questions, :created_by
    add_column :questions, :user_id, :integer
  end

  def down
    remove_column :questions, :user_id
    add_column :questions, :created_by, :integer
  end
end
