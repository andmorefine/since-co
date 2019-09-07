# frozen_string_literal: true

require Rails.root.join('app/services/twitter/favorite_service.rb')

namespace :task_tweet_count do
  desc 'リセット'
  task reset: :environment do
    tweet = Twitter::FavoriteService.new
    tweet.reset_increment
  end
end
