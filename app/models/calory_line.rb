class CaloryLine < ActiveRecord::Base
  attr_accessible :net_weight, :energy, :product_id, :day_id

  belongs_to :product
  belongs_to :day

  validates_presence_of :net_weight, :product_id, :day_id
  validates_numericality_of :net_weight, :greater_than => 10, :less_than => 5000

  def self.get_by_user(user)
    find_by_sql( "select calory_lines.*, days.* from calory_lines " +
      "inner join days on calory_lines.day_id = days.id where days.user_id = #{user.id} order by days.enter_date DESC")
  end

  def total_calories
      (net_weight.to_f / 100) * energy
  end

  def to_s
    "#{net_weight} g of #{product.name} on #{day.enter_date.to_s}"
  end

end

