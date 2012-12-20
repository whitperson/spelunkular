class HomeController < ApplicationController
  def index
  end

  def scraper
    @url = params[:url]
    @raw_data = HTTParty.get(@url)
    img_regex = /<img .*?.*?['"](http[^'"]*)['"]/m
    image_urls = @raw_data.scan(img_regex).flatten.uniq
      image_urls.each do |u|
        Image.create(:url => u)
      end
    @images = Image.all

    @new_urls = []
    link_regex = /<a .*?['"](http[^'"]*)['"]/m
    urls = @raw_data.scan(link_regex).flatten.uniq
      urls.each do |link|
        if !URI.parse(link).relative?
          @new_urls << link
        end
      end
    # @times = params[:depth]
    # loop_num = @new_urls.length
    # @new_urls.each

    #   loop_num.times do |link|
    #     scraper(link)
    #   end
  end
end