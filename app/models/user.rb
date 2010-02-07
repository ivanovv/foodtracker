class User < ActiveRecord::Base
  #attr_accessible :username, :email, :password, :born, :height, female
  acts_as_authentic
    
  validates_presence_of :username, :email, :born, :height
  validates_numericality_of :height
    
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
    
end
