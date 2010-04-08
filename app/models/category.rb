class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :products

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.search_by_product_name(product_name)
    if product_name
      #find_by_sql( "select distinct categories.* from categories inner join products " +
      #"on products.category_id = categories.id where products.name like '%#{product_name}%'")
      select("distinct(*)").joins(:products).where("products.name like '%#{product_name}%'")
    else
      all
    end
  end

  def to_s
    name
  end

  #def to_param
  # name.split()[0]
  #end

end

