require 'test_helper'

class DayTest < ActiveSupport::TestCase
  test "new day should not be valid" do
    assert !Day.new.valid?
  end

  test "to_param should return formatted enter date" do
    d = Day.new
    d.enter_date = Date.today
    assert_equal d.to_param, Date.today.strftime("%Y-%m-%d"), "to_param returned smth different from formatted enter_date"
  end

  test "base metabolic rate is calculated correctly" do
    d = Day.new
    d.weight = 60
    d.user = users(:vic)
    assert_equal d.base_metabolic_rate, users(:vic).base_metabolic_rate(60), "weight was calculated incorrectly"
  end

  test "calc total calories" do
    d = days(:one)
    assert_equal d.total_calories, (calory_lines(:one).net_weight.to_f / 100 * calory_lines(:one).energy) +
      (calory_lines(:two).net_weight.to_f / 100 * calory_lines(:two).energy), "total calories were calculated wrong"
  end


end

