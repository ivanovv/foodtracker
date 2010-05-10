class CaloryLine < ActiveRecord::Base
  attr_accessible :net_weight, :energy, :product_id, :day_id

  belongs_to :product
  belongs_to :day

  validates_presence_of :net_weight, :product_id, :day_id
  validates_numericality_of :net_weight, :greater_than => 2, :less_than => 5000
  validates_inclusion_of :net_weight, :in => 3..4999

  scope :for_current_user, lambda {
    joins(:days).where("days.user_id = ?", UserSession.find.user.id)
  }

  scope :user, proc {|user| joins(:day).where("days.user_id = ?", user.id)}

  scope :by_enter_date, order("days.enter_date DESC")

  scope :user_full, proc{ |user| includes(:day, :product).
        where("days.user_id = :user_id", {:user_id => user.id}).by_enter_date }

  def self.get_by_user(user)
      user(user).by_enter_date
  end

  def total_calories
      (net_weight.to_f / 100) * energy
  end

  def to_s
    "#{net_weight} g of #{product.name} on #{day.enter_date.to_s}"
  end

end

