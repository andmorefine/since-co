# frozen_string_literal: true

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '5:00 am' do
  rake '-s sitemap:refresh'
end

every 1.day, at: '0:00 am' do
  rake "task_tweet_favorite:reset"
end

every 2.hours do
  rake "task_tweet_favorite:post"
end

every 1.week do
  command "rm -rf #{Rails.root}/log/production.log"
  command "touch #{Rails.root}/log/production.log"
end
