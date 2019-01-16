class ProverbController < ApplicationController

  def index
    @proverbs = Proverb.all
  end

  def show
    @proverb = Proverb.find_by_id(params[:id])
  end

end
