require 'test_helper'

class CaloryLineTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CaloryLine.new.valid?
  end
end
