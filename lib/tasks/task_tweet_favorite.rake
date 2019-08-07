# frozen_string_literal: true

require Rails.root.join("app/services/twitter/favorite_service.rb")

namespace :task_tweet_favorite do
  desc "ツイートにいいね"
  task post: :environment do
    tweet = Twitter::FavoriteService.new
    tweet.push_favorite
  end
end

namespace :task_tweet_favorite do
  desc "リセット"
  task reset: :environment do
    tweet = Twitter::FavoriteService.new
    tweet.reset_increment
  end
end
