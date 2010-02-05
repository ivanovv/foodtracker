class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :category_id
      t.string :name
      t.float :water
      t.float :protein
      t.float :fat
      t.float :carbohydrate
      t.integer :energy
      t.timestamps
    end
  end
  
  def self.down
    drop_table :products
  end
end
