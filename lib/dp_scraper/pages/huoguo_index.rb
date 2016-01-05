class DpScraper::HuoguoIndex 

	attr_accessor :browser, :vendors

	def initialize(browser: nil)
		@browser = browser
		@vendors = []
	end

	def scrape_page
		content = browser.div(class_name: 'content')

		vendor_list = content.uls.last #use 2nd list, 1st list is menu

		vendor_list.lis.each do |vendor_li|

			next unless vendor = self.scrape_vendor(li: vendor_li)

			self.vendors << vendor

			##
			##  print results
			##
			puts("===========================================================")
			puts("#{vendor.name}   [#{shop_type}] [#{shop_area}]\n
					address:  #{address}\n
					image_url:   #{image_url}\n
					promotion:   #{promotion}\n\n")
		end

		return self.vendors

	end

	def scrape_content(content:)
		
	end

	def scrape_vendor(li: )

		# check if have 优惠
		return false unless li.link(class_name: 'tuan').exists?
		#非团购优惠
		#return false unless li.span(class_name: 'tit').exists?

		# shop pic thumbnail
		image_url = vendor_li.img.src

		# title in <h4>
		name = vendor_li.h4.text 

		# address
		address = vendor_li.span(class_name: 'addr').text

		# tags -- there will be 2, "火锅" and "八佰伴"
		tags = vendor_li.spans(class_name: 'tag')
			# type 
			shop_type = tags[0].text

			# area e.g. 八佰伴, 五角场
			shop_area = tags[1].text

		# promotions, 团购 mixed in with 优惠
		# 优惠 seems to be in .tuan.priviledge
		promotion = vendor_li.link(class_name: 'tuan').title

		## coupon
		coupon = DpScraper::Coupon.new(title: promotion)

		## vendor
		##
		## TODO: get city/district/province
		vendor = DpScraper::Vendor.new(name: name, image_url: image_url, street: address)
		vendor.shop_type = shop_type
		vendor.shop_area = shop_area
		vendor.coupons << coupon

		return vendor
	end
end