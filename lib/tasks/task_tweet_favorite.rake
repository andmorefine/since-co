# frozen_string_literal: true

namespace :task_tweet_favorite do
  desc "ツイートにいいね"
  task :post do
    Twitter::FavoriteService.new.create
  end
end
