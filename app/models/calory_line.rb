class CaloryLine < ActiveRecord::Base
  attr_accessible :net_weight, :energy, :product_id, :day_id

  belongs_to :product
  belongs_to :day
  
  validates_presence_of :net_weight
  validates_numericality_of :net_weight
  
  def total_calories
      net_weight * energy
  end
  
end
