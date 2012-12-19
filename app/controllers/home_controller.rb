class HomeController < ApplicationController
  def index
  end

  def scraper
    @url = params[:url]
    @raw_data = HTTParty.get(@url)
    img_regex = /<img .*?.*?['"](http[^'"]*)['"]/m
    urls = @raw_data.scan(img_regex).flatten.uniq
      urls.each do |u|
        Image.create(:url => u)
      end
    @images = Image.all
    get_links
  end

  def get_links
    @raw_data = HTTParty.get(@url)
    link_regex = /<a .*?['"](http[^'"]*)['"]/m
    urls = @raw_data.scan(link_regex).flatten.uniq
    # URI.parse(url)
    # binding.pry
  end

end