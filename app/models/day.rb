class Day < ActiveRecord::Base
  attr_accessible :enter_date, :weight
  
  validates_presence_of :enter_date
  validates_uniqueness_of :enter_date, :scope=> [:user_id]
  validates_presence_of :weight
  validates_numericality_of :weight
  
  belongs_to :user  
  has_many :calory_lines

  def to_param
    "#{enter_date.year.to_s}-#{enter_date.month.to_s}-#{enter_date.day.to_s}"
  end
end
