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

			@url = url || "http://www.dianping.com/search/category/1/10/g110"
			@browser = Watir::Browser.new :firefox

			@browser.goto @url
		end

		def crawl
			index_scraper = HuoguoIndex.new(browser: self.browser)
			index_scraper.scrape_page
			self.vendors += index_scraper.vendors

			puts "********************"
			puts "total vendors: #{self.vendors.count} found"
		end

		def next_page

		end


	end
end

