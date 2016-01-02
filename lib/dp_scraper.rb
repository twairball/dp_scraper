require "dp_scraper/version"
require "watir-webdriver"

module DpScraper
	class DpScraper 

		attr_reader :browser

		def initialize(url:)
			@url = :url || "http://www.dianping.com/search/category/1/10/g110"
			@browser = Watir::Browser.new :firefox

			@browser.goto @url
		end

		def scrape
			content = browser.div(class_name: 'content')

			vendor_list = content.uls.last #use 2nd list, 1st list is menu

			vendor_list.lis.each do |vendor_li|

				# check if have 优惠
				next unless vendor_li.link(class_name: 'tuan').exists?

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

				##
				##  print results
				##
				puts("===========================================================")
				puts("#{name}   [#{shop_type}] [#{shop_area}]\n
						address:  #{address}\n
						image_url:   #{image_url}\n
						promotion:   #{promotion}\n\n")

			end

		end
	end
end

require 'dp_scraper/models'