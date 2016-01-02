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

		def crawl

		end

		def next_page

		end


	end
end

require 'dp_scraper/models'
require 'dp_scraper/pages'