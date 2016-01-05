class DpScraper::Coupon

	attr_reader :title, :description, :limit_time

	def initialize(title: nil, description: nil, limit_time: nil)
		@title = title
		@description = description
		@limit_time = limit_time
	end
	
end