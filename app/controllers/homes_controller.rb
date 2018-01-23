class HomesController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  def top
    uri = "https://weather.yahoo.co.jp/weather/jp/3.html?day=1"
    @doc = Nokogiri::HTML(open(uri), nil, "utf=8")
  end
end
