class DpScraper::HuoguoDetail

	attr_accessor :browser, :vendor

	def initialize(browser: nil)
		@browser = browser
		@vendor = nil
	end

	def scrape_page
		content = browser.div(class_name: 'main')

		## main content
		##

		# shop name contains child nodes
		shop_name = content.h1(class_name: 'shop-name').text
		shop_name = shop_name.split("\n").first

		# content.span(css: 'span[itemprop]= "locality region"').text
		district = content.span(itemprop: 'locality region').text

		street = content.span(itemprop: 'street-address').text

		tel = content.span(itemprop: 'tel').text

		## image url, get from .photo-header first img
		#火锅图片
		photo_div = browser.div(class_name: 'photo-header')

		##足疗按摩图片
		#photo_div = browser.div(class_name: 'photos')

		if photo_div.imgs.count > 0 
			image_url = photo_div.img.src
		else
			image_url = nil
		end



		## instantiate vendor
		self.vendor = DpScraper::Vendor.new(name: shop_name, district: district, street: street, tel: tel, image_url: image_url)

		## get coupons
		coupon_as = browser.links(class_name: /J_short-promo/)
		coupon_as.each do |coupon_a|
		
			coupon = self.scrape_coupon(coupon_a)
			self.vendor.coupons << coupon
		end
		
		return self.vendor
	end

	def scrape_coupon(coupon_a)

		title = "促销"
		description = coupon_a.text.split("\n").last

		## instantiate coupon
		coupon = DpScraper::Coupon.new(title: title,description: description)
		return coupon
	end

end