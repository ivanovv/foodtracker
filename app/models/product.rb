class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :water, :protein, :fat, :carbohydrate, :energy
  
  belongs_to :category
  
  validates_presence_of :name, :energy, :category_id
  validates_uniqueness_of :name
  validates_numericality_of :water, :protein, :fat, :carbohydrate, :energy
end
