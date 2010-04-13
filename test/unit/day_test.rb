require 'test_helper'

class DayTest < ActiveSupport::TestCase

  should_belong_to :user
  should_have_many :calory_lines

  should "new day not be valid" do
    assert !Day.new.valid?
  end

  should "return formatted enter date as to_param" do
    d = Day.new
    d.enter_date = Date.today
    assert_equal d.to_param, Date.today.strftime("%Y-%m-%d"), "to_param returned smth different from formatted enter_date"
  end

  should "calculate base metabolic rate correctly" do
    d = Day.new
    d.weight = 60
    d.user = users(:vic)
    assert_equal d.base_metabolic_rate, users(:vic).base_metabolic_rate(60), "weight was calculated incorrectly"
  end

  should "calc total calories" do
    d = days(:one)
    assert_equal d.total_calories, (calory_lines(:one).net_weight.to_f / 100 * calory_lines(:one).energy) +
      (calory_lines(:two).net_weight.to_f / 100 * calory_lines(:two).energy), "total calories were calculated wrong"
  end


end

