class HomeController < ApplicationController
  def index
    @proverb_count = Proverb.all.count
  end
end
