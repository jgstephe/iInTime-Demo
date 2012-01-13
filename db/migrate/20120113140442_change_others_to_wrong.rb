class ChangeOthersToWrong < ActiveRecord::Migration
  def self.up
    remove_column :questions, :other_a
    remove_column :questions, :other_b
    remove_column :questions, :other_c
    remove_column :questions, :other_d
    add_column :questions, :wrong, :text 
  end

  def self.down
    remove_column :questions, :wrong
    add_column :questions, :other_a, :string
    add_column :questions, :other_b, :string
    add_column :questions, :other_c, :string
    add_column :questions, :other_d, :string
  end
end
