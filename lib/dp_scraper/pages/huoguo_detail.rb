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
		photo_div = browser.div(class_name: 'photo-header')

		if photo_div.imgs.count > 0 
			image_url = photo_div.img.src
		else
			image_url = nil
		end

		## instantiate vendor
		self.vendor = DpScraper::Vendor.new(name: shop_name, district: district, street: street, tel: tel, image_url: image_url)

		return self.vendor
	end

end