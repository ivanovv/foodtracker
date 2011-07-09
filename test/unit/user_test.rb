require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many :days
  should validate_numericality_of :height
  should have_authlogic

  should "new user be invalid" do
    assert !User.new.valid?
  end

  should "calc age" do
    vic = users(:vic)
    assert_equal vic.age, (Date.today - vic.born).to_i / 365
  end

  should "to_s be equal to username" do
    vic = users(:vic)
    assert_equal vic.to_s, vic.username, "vic.to_s isn't equal to vic.username"
  end

  should "calc base metabolic rate" do
    vic = users(:vic)
    assert_equal vic.base_metabolic_rate(60),
      (10 * 60) + (6.25 * vic.height) - (5 * vic.age) + 5, "base metabolic rate differs"
  end

  should "not allow born date less than 120 years from now" do
    u = users(:vic)
    u.born = 130.years.ago
    assert !u.save, "saved a person who is 130 years old"
  end

end

