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
			puts("#{vendor.name}   [#{vendor.district}]\n
					address:  #{vendor.street}\n
					image_url:   #{vendor.image_url}\n
					coupons:   #{vendor.coupons.count}\n\n")
		end

		return self.vendors

	end

	def scrape_vendor(li: )

		# check if have 优惠
		return false unless li.link(class_name: 'tuan').exists?
		#非团购优惠
		#return false unless li.link(class_name: 'tit').exists?

		# get url for detail page
		detail_link = li.link(data_hippo_type: 'shop')

		return false unless detail_link.exists?
		detail_url = detail_link.href


		# make new browser
		new_browser = Watir::Browser.new :firefox
		new_browser.goto detail_url
		detail_page = DpScraper::HuoguoDetail.new(browser: new_browser)

		vendor = detail_page.scrape_page

		new_browser.close
		
		return vendor 
	end
end