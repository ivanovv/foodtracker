class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :water, :protein, :fat, :carbohydrate, :energy

  belongs_to :category
  has_many :calory_lines

  validates_presence_of :name, :energy, :category_id
  validates_uniqueness_of :name
  validates_numericality_of :protein, :fat, :carbohydrate, :water
    {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates_numericality_of :energy, :greater_than => -1, :less_than => 700

  validates_inclusion_of :protein, :fat, :carbohydrate, :water, :in => 0..100
  validates_inclusion_of :energy, :in => 0..700

  scope :ordered_by_name, order("name ASC")

  def self.search(product_name = nil)
    if product_name
      where('name like ?', "%#{product_name}%")
    else
      scoped
    end
  end

  def to_s
    name
  end

end

