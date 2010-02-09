class CreateCaloryLines < ActiveRecord::Migration
  def self.up
    create_table :calory_lines do |t|
      t.integer :day_id
      t.integer :product_id
      t.integer :net_weight
      t.float :energy
      t.timestamps
    end
  end
  
  def self.down
    drop_table :calory_lines
  end
end
