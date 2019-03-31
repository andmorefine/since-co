# frozen_string_literal: true
require 'faraday'

class Chatwork::MessageService
  CHATWORK_TOKEN = ENV['CHATWORK_TOKEN']
  VERSION = 'v2'.freeze

  def initialize(params = {})
    @room_id = params[:room_id]
    @body = params[:body]
  end

  def create
    conn = Faraday::Connection.new(url: 'https://api.chatwork.com') do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Response::Logger
      builder.use Faraday::Adapter::NetHttp
    end

    response = conn.post do |request|
      request.url "/#{VERSION}/rooms/#{@room_id}/messages"
      request.headers = {
        'X-ChatWorkToken' => CHATWORK_TOKEN
      }
      request.params[:body] = @body # => ここに入れる文字が投稿される
    end
  end
end
