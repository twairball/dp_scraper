require "dp_scraper/version"
require "watir-webdriver"

# watir extensions
require 'watir/element_locator'

# lib
require 'dp_scraper/models'
require 'dp_scraper/pages'


module DpScraper
	class DpScraper 

		attr_reader :browser
		attr_accessor :vendors

		def initialize(url: nil)
			@vendors = []

			page = 1

			for page in 1..50

				@url = url || "http://www.dianping.com/search/category/1/10/g110p" + page.to_s			
				@browser = Watir::Browser.new :firefox
				@browser.goto @url
				puts("page: #{page}")

				self.crawl
				page = page + 1

		    end

		end

		def crawl
			index_scraper = HuoguoIndex.new(browser: self.browser)
			index_scraper.scrape_page
			self.vendors += index_scraper.vendors

			puts "******************************************"
			puts "total vendors: #{self.vendors.count} found"
		end

		def next_page

		end

	end
end

