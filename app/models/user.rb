class User < ActiveRecord::Base
  #attr_accessible :username, :email, :password, :born, :height, female
  acts_as_authentic
    
  validates_presence_of :username, :email, :born, :height
  validates_numericality_of :height
    
  def age
    (Date.today - born).to_i / 365
  end 
    
end
