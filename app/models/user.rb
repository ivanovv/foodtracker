class User < ActiveRecord::Base
  #attr_accessible :username, :email, :password, :born, :height, female
  acts_as_authentic

  validates_presence_of :username, :email, :born, :height
  validates_numericality_of :height, :greater_than_or_equal_to => 130, :less_than_or_equal_to => 250

  validate :born_date_cannot_be_120_years_ago

  has_many :days

  def age
    (Date.today - born).to_i / 365
  end

  def base_metabolic_rate(weight)
    base = (10 * weight) + (6.25 * height) - (5 * age)
    if female then
        base - 161
    else
        base + 5
    end
  end

  def to_s
    username
  end

  private

  def born_date_cannot_be_120_years_ago
    errors.add(:born, "can't be older than 120 years ago") if !born.blank? and 120.years.ago > born
  end

end

