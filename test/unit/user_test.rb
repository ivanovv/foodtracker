require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_have_many :days
  should_validate_numericality_of :height

  should "new user be invalid" do
    assert !User.new.valid?
  end

  should "calc age" do
    vic = users(:vic)
    assert_equal vic.age, (Date.today - vic.born).to_i / 365
  end

  should "to_s be equal to username" do
    vic = users(:vic)
    assert_equal vic.to_s, vic.username, "vic.to_s isn't equal to vic.username'"
  end

  should "calc base metabolic rate" do
    vic = users(:vic)
    assert_equal vic.base_metabolic_rate(60),
      (10 * 60) + (6.25 * vic.height) - (5 * vic.age) + 5, "base metabolic rate differs"
  end

end

