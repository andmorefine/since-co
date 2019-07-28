# frozen_string_literal: true

CHATWORK_ROOM = 140_834_301

class Twitter::FavoriteService
  def initialize(params = {}); end

  def push_favorite
    search_words = ["イラスト", "絵描きさんと繋がりたい", "イラスト好きな人とつながりたい", "創作の輪"]
    word = search_words.sample
    tweets = client.search("#" + word, result_type: "mixed").take(100)
    client.favorite!(tweets)
    Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: word).create
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
