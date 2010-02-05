class ChangeLoginCountFieldTypeForUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :login_count    
    remove_column :users, :failed_login_count
    add_column :users, :login_count, :integer
    add_column :users, :failed_login_count, :integer
  end

  def self.down
    remove_column :users, :failed_login_count
    remove_column :users, :login_count
    add_column :users, :login_count, :string
    add_column :users, :failed_login_count, :string
  end
end
