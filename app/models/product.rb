class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :water, :protein, :fat, :carbohydrate, :energy
  
  belongs_to :category
  has_many :calory_lines
  
  validates_presence_of :name, :energy, :category_id
  validates_uniqueness_of :name
  validates_numericality_of :water, :protein, :fat, :carbohydrate, :energy

  def self.search(product_name)
    if product_name
      find(:all, :conditions => ['name like ?', "%#{product_name}%"])
    else
      find(:all)
    end
  end
end
