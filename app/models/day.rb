class Day < ActiveRecord::Base
  attr_accessible :enter_date, :weight

  validates_presence_of :enter_date
  validates_uniqueness_of :enter_date, :scope=> [:user_id]
  validates_presence_of :weight
  validates_numericality_of :weight

  belongs_to :user
  has_many :calory_lines

  def self.find_by_date(date = Date.today)
    find_by_enter_date_and_user_id(date, UserSession.find.user)
  end

  def to_param
    "#{enter_date.year.to_s}-#{enter_date.month.to_s}-#{enter_date.day.to_s}"
  end

  def to_s
    to_param
  end

  def to_label
    enter_date.to_param
  end

  def base_metabolic_rate
    user.base_metabolic_rate(weight)
  end

  def total_calories
    result = 0
    calory_lines.each do |calory_line|
      result += calory_line.total_calories
    end
    result
  end

end

