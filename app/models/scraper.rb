require 'nokogiri'
require 'open-uri'

class Scraper

  attr_reader :url, :data

  def initialize(url)
    @url = url
  end

  def get_properties(property)
    data.search(property).map do 
      |e| e.inner_text
    end
  end

  def get_img
    src = 'http://www.epicurious.com' + data.at('.photo')['src'].to_s
  end

  def data
    @data ||= Nokogiri::HTML(open(url))
  end

end