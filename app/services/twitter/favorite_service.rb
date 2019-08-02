# frozen_string_literal: true

class Twitter::FavoriteService

  CHATWORK_ROOM = 159_446_379

  def initialize(params = {}); end

  def push_favorite
    search_words = ["イラスト", "絵描きさんと繋がりたい", "artwork"]
    word = search_words.sample
    tweets = client.search("#" + word, result_type: "recent").take(50)
    rate_limit_status = client.__send__(:perform_get, '/1.1/application/rate_limit_status.json')
    body_text = word + "（" + tweets.count.to_s + "）"
    # 15分当たり上限回数・残存回数・リセット時刻
    limit = client.rate_limit_status("/search/tweets")
    begin
      client.favorite!(tweets)
      Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text).create
    rescue => error
      body_text = word + " error（" + error.to_s + "）"
      Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text + limit.to_s).create
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

class Twitter::REST::Client
  def rate_limit_status(path)
    result_hash = rate_limit_status_all[path.to_sym]
    result_hash[:time_now] = rate_limit_status_all[:time_now]
    result_hash
  end

  def rate_limit_status_all
    result_hash = {}
    result_hash[:time_now] = Time.now
    rate_limits = perform_get('/1.1/application/rate_limit_status.json')[:resources]
    rate_limits.each do |genre, path_limits|
      path_limits.each do |path, limits|
        limits[:reset_time] = Time.at(limits[:reset])
        result_hash[path] = limits
        result_hash[path.to_s] = limits
      end
    end
    result_hash
  end
end