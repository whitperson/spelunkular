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
    new_urls = []
    @raw_data = HTTParty.get(@url)
    link_regex = /<a .*?['"](http[^'"]*)['"]/m
    urls = @raw_data.scan(link_regex).flatten.uniq
      urls.each do |link|
        if !URI.parse(link).relative?
        new_urls << link
        end
      end
    # binding.pry
  end

end