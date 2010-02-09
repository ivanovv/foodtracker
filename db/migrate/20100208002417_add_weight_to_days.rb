class AddWeightToDays < ActiveRecord::Migration
  def self.up
    add_column :days, :weight, :decimal, :precision => 5, :scale => 1
  end

  def self.down
    remove_column :days, :weight
  end
end
