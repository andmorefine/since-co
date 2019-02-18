class HomeController < ApplicationController
  def index
    @proverb_count = Proverb.all.count
    @twitters = Twitter::ClientService.new().fetch
  end
end
