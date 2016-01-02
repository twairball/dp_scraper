require 'test_helper'


class CouponTest < Minitest::Test

  def setup
    @title = "hello coupon"
    @desc = "awesome coupon!!"
    @coupon = DpScraper::Coupon.new(title: @title, description: @desc)
  end

  def test_initializer
  	assert_equal @title, @coupon.title
    assert_equal @desc, @coupon.description
  end
end
