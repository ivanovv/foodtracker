class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.date :enter_date
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :days
  end
end
