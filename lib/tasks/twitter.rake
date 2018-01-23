require 'twitter'
require 'open-uri'
require 'nokogiri'

namespace :twitter do
  desc "Twitter朝７時に天気予報を投稿"
  task :tweet => :environment do
    uri = "https://weather.yahoo.co.jp/weather/jp/3.html?day=1"
    @doc = Nokogiri::HTML(open(uri), nil, "utf=8")
    client = get_twitter_client
    tweet1 =  "今日 | #{ Date.today }
    の天気予報は" + @doc.xpath('//*/ul/li[6]/a/dl/dd/span').text

    update(client, tweet1)
  end
end

def get_twitter_client
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = "<%= ENV['CONSUMER_KEY'] %>"
    config.consumer_secret = "<%= ENV['CONSUMER_SECRET'] %>"
    config.access_token = "<%= ENV['ACCESS_TOKEN'] %>"
    config.access_token_secret = "<%= ENV['ACCESS_TOKEN_SECRET'] %>"
  end
  @client
end

def update(client, tweet)
  begin
    tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
    client.update(tweet.chomp)
  rescue => e
    Rails.logger.error "<<twitter.rake::tweet.update ERROR : #{e.message}>> "
  end
end
