# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @proverb_count = Proverb.all.count
    @proverb_radom = Proverb.active.image_active.sample(3).shuffle
    @proverb_image = Proverb.active.image_active.sample(1).first.image
    # @twitters = Twitter::ClientService.new.fetch
  end
end
