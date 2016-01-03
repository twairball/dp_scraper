class DpScraper::Vendor

	attr_reader :name, :image_url, :tel, :street, :district, :city, :province, :coupons, :shop_type, :shop_area

	def initialize(name: nil, image_url: nil, tel: nil, street: nil, district: nil, city: nil, province: nil, coupons: [])
		@name = name
		@image_url = image_url
		@tel = tel
		@street = street
		@district = district
		@city = city
		@province = province
		@coupons = coupons 
	end




end