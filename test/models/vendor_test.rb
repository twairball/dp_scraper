require 'test_helper'


class VendorTest < Minitest::Test

  def setup
  	@name = "hello vendor"
  	@street = "888 番禺路"
  	@district = "徐汇区"
  	@city = "上海市"
  	@province = "上海"
  	@image_url = "http://hello.com/img123123.png"

  	@vendor = Vendor.new(name: @name, street: @street, district: @district, city: @city, province: @province, image_url: @image_url)

  end

  def test_initializer
  	assert_equal @name, @vendor.name
  	assert_equal @street, @vendor.street
  	assert_equal @district, @vendor.district
  	assert_equal @city, @vendor.city
  	assert_equal @province, @vendor.province
  	assert_equal @image_url, @vendor.image_url
  end

  def test_has_coupons
  	coupon1 = Coupon.new(title: 'coupon1')
  	coupon2 = Coupon.new(title: 'coupon2')

  	# assign
  	@vendor.coupons << coupon1
  	@vendor.coupons << coupon2

  	assert @vendor.coupons.include?(coupon1)
	assert @vendor.coupons.include?(coupon2)

  end

end
