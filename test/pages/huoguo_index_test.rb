require 'test_helper'


class HuoguoIndexTest < Minitest::Test

  def setup
  	@huoguo = DpScraper::HuoguoIndex.new()
  end

  def test_initializer
  	assert_equal [], @huoguo.vendors
  end

  def test_scrape_page
  	
  end


end
