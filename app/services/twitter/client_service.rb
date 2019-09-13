# frozen_string_literal: true

class Twitter::ClientService
  def initialize(params = {}); end

  def fetch
    client.search('#ことわざ', lang: 'ja', include_entities: true).take(5).collect
  rescue => e
    []
  end

  def create; end

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
