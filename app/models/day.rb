class Day < ActiveRecord::Base
  attr_accessible :enter_date, :weight

  validates_presence_of :enter_date
  validates_uniqueness_of :enter_date, :scope=> [:user_id]
  validates_presence_of :weight
  validates_numericality_of :weight

  belongs_to :user
  has_many :calory_lines

  scope :for_current_user, lambda {
    where("user_id = ?", UserSession.find.user)
  }

  scope :user, proc { |user| where(:user => user) }
  scope :date, proc { |date|
    if date == nil
      where(:enter_date => Date.today)
    else
      where(:enter_date => date)
    }

  scope :recent, order("enter_date DESC")



  def self.find_by_date(date = Date.today)
    find_by_enter_date_and_user_id(date, UserSession.find.user)
  end

  def to_param
    enter_date.strftime("%Y-%m-%d")
  end

  def to_s
    current = Date.today
    case
    when enter_date.year != current.year
      to_param
    when enter_date.yday == (current.yday + 1)
      I18n.t(:tomorrow)
    when enter_date.yday == current.yday
      I18n.t(:today)
    when enter_date.yday == (current.yday - 1)
      I18n.t(:yesterday)
    when (current.yday - enter_date.yday).abs < 7
      enter_date.strftime("%A, %d %b")
    else
      enter_date.strftime("%d %b")
    end
  end

  def to_label
    to_s
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

