# frozen_string_literal: true

class Twitter::FavoriteService
  CHATWORK_ROOM = 159_446_379

  def initialize(params = {}); end

  def push_favorite
    search_words = %w[イラスト 絵描きさんと繋がりたい artwork イラスト好きな人と繋がりたい illustration お絵描き好きさんと繋がりたい]
    word = search_words.sample

    # # 国トレンド取得
    # trends_available = client.__send__(:perform_get, '/1.1/trends/available.json')
    # contry_woeids = []
    # trends_available.each do |item|
    #   if item[:countryCode] == 'JP'
    #     contry_woeids.push(item[:woeid])
    #   end
    # end
    # woeid = contry_woeids.sample

    # # woeid からトレンド取得
    # trends_place = client.__send__(:perform_get, "/1.1/trends/place.json?id=#{woeid}")
    # word_items = []
    # trends_place[0][:trends].each do |item|
    #   word_items.push(item[:name].delete("#"))
    # end
    # word = word_items.sample

    rando = Random.new
    rando_num = rando.rand(20..40)

    # いいね準備
    tweets = client.search('#' + word, result_type: 'recent').take(rando_num)
    rate_limit_status = client.__send__(:perform_get, '/1.1/application/rate_limit_status.json')
    # 15分当たり上限回数・残存回数・リセット時刻
    limit = client.rate_limit_status('/search/tweets')
    twitter_count = Count.twitter
    return if twitter_count.count > twitter_count.limit

    random = Random.new
    random_num = random.rand(10..30)

    begin
      favorite_list = []
      tweets.each do |tweet|
        sleep(random_num)
        ok = client.favorite(tweet.id)
        favorite_list.push(tweet.id) if ok.present?
      end
      twitter_count.increment!(:count, tweets.count)
      body_text = word + '（' + favorite_list.count.to_s + '/' + tweets.count.to_s + '）（' + twitter_count.count.to_s + '/' + twitter_count.limit.to_s + '）'
      Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text).create
    rescue => error
      body_text = word + ' error（' + error.to_s + '）'
      Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text).create
    end
  end

  def reset_increment
    twitter_count = Count.twitter
    twitter_count.update!(count: 0)
    body_text = 'リセットしました'
    Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: body_text).create
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
    rate_limits.each do |_genre, path_limits|
      path_limits.each do |path, limits|
        limits[:reset_time] = Time.at(limits[:reset])
        result_hash[path] = limits
        result_hash[path.to_s] = limits
      end
    end
    result_hash
  end
end
