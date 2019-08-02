# frozen_string_literal: true

class Twitter::FavoriteService

  CHATWORK_ROOM = 159_446_379

  def initialize(params = {}); end

  def push_favorite
    search_words = ["イラスト", "絵描きさんと繋がりたい", "artwork"]
    word = search_words.sample
    tweets = client.search("#" + word, result_type: "recent").take(10)
    body_text = word + "（" + tweets.count.to_s + "）"
    begin
      # client.favorite!(tweets)
      Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text).create
    rescue => e
      body_text = word + "error（" + e.to_s + "）"
      Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text).create
    end
  end

  private

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SERCET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end
end
