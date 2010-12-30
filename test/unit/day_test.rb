require 'test_helper'

class DayTest < ActiveSupport::TestCase

  should belong_to :user
  should validate_presence_of :user_id, :enter_date, :weight
  should have_many :calory_lines
  should ensure_value_in_range :weight, 20..200

  should "new day not be valid" do
    assert !Day.new.valid?
  end

  should "return formatted enter date as to_param" do
    d = Day.new(:enter_date => Date.today)
    assert_equal d.to_param, Date.today.strftime("%Y-%m-%d"), "to_param returned smth different from formatted enter_date"
  end

  should "calculate base metabolic rate correctly" do
    d = Day.new(:weight => 60)
    d.user = users(:vic)
    assert_equal d.base_metabolic_rate, users(:vic).base_metabolic_rate(60), "weight was calculated incorrectly"
  end

  should "calc total calories" do
    d = days(:one)
    assert_equal d.total_calories, (calory_lines(:one).net_weight.to_f / 100 * calory_lines(:one).energy) +
      (calory_lines(:two).net_weight.to_f / 100 * calory_lines(:two).energy), "total calories were calculated wrong"
  end

  should "calc the amount of calories the user can still eat" do
    d = Day.new(:weight => 60)
    d.user = users(:vic)
    assert_equal d.to_eat, d.base_metabolic_rate - d.total_calories, "to_eat returned something wrong"
  end

end

