class CaloryLine < ActiveRecord::Base
  attr_accessible :net_weight, :energy, :product_id, :day_id

  belongs_to :product
  belongs_to :day

  validates_presence_of :net_weight
  validates_numericality_of :net_weight

  def self.get_by_user(user)
      joins(:days).where("days.user_id = ?", user.id).order("days.enter_date")
  end

  def total_calories
      (net_weight.to_f / 100) * energy
  end

  def to_s
    "#{net_weight} g of #{product.name} on #{day.enter_date.to_s}"
  end

end

