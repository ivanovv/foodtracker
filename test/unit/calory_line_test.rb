require 'test_helper'

class CaloryLineTest < ActiveSupport::TestCase

  should belong_to :product
  should belong_to :day
  should validate_presence_of :net_weight
  should validate_presence_of :product_id
  should validate_presence_of :day_id

  should validate_numericality_of :net_weight
  should ensure_inclusion_of(:net_weight).in_range(3..4999)

  should "new calory line be invalid" do
    assert !CaloryLine.new.valid?
  end

  should "calc total_calories" do
    assert_equal calory_lines(:two).total_calories, (calory_lines(:two).net_weight.to_f / 100) * calory_lines(:two).energy,
       "total_calories calc failed"
  end

  should "set custom to_s" do
    assert_equal calory_lines(:two).to_s,
      "#{calory_lines(:two).net_weight} g of #{calory_lines(:two).product.name} on #{calory_lines(:two).day.enter_date.to_s}",
      "something wrong with to_s"
  end

  should "search by user and return most recent records" do
    cl = CaloryLine.get_by_user(users(:vic))
    assert_equal cl[0].product_id, calory_lines(:three).product_id
    assert_equal cl[0].day_id, calory_lines(:three).day_id
    assert_equal cl.size, 3
  end

end

