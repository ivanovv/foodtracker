class AddHeightToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :height, :integer
    add_column :users, :born, :date
    add_column :users, :female, :boolean
  end

  def self.down
    remove_column :users, :female
    remove_column :users, :born
    remove_column :users, :height
  end
end
