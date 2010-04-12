require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be invalid" do
    assert !User.new.valid?
  end

  test "should calc age" do
    vic = users(:vic)
    assert_equal vic.age, (Date.today - vic.born).to_i / 365
  end

  test "height should be numeric" do
    vic = users(:vic)
    vic.height = "two meters"
    assert !vic.valid?, "user with height 'two meters' is valid"
  end

  test "to_s should be equal to username" do
    vic = users(:vic)
    assert_equal vic.to_s, vic.username, "vic.to_s isn't equal to vic.username'"
  end

  test "should calc base metabolic rate" do
    vic = users(:vic)
    assert_equal vic.base_metabolic_rate(60),  (10 * 60) + (6.25 * vic.height) - (5 * vic.age) + 5, "base metabolic rate differs"
  end

end

