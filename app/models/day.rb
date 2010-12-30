class Day < ActiveRecord::Base
  attr_accessible :enter_date, :weight

  validates_presence_of :enter_date, :weight, :user_id
  validates_uniqueness_of :enter_date, :scope=> [:user_id]
  validates_numericality_of :weight, :greater_than_or_equal_to => 20, :less_than_or_equal_to => 200
  validates_inclusion_of :weight, :in => 20..200


  belongs_to :user
  has_many :calory_lines

  scope :for_current_user, lambda {
    where("user_id = ?", UserSession.find.user)
  }

  scope :user, proc { |user| where(:user => user).all }
  scope :date, proc { |date|
    if date
      where(:enter_date => date).first
    else
      where(:enter_date => Date.today).first
    end
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
#    when enter_date.yday == (current.yday + 1)
#      I18n.t(:tomorrow)
#    when enter_date.yday == current.yday
#      I18n.t(:today)
#    when enter_date.yday == (current.yday - 1)
#      I18n.t(:yesterday)
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
    calory_lines.inject(0) { |sum, calory_line| sum + calory_line.total_calories }
  end

  def to_eat
    user.base_metabolic_rate(weight) - total_calories
  end

end

