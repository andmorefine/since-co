class ProverbController < ApplicationController

  def index
    @proverbs = Proverb.all.order(created_at: :desc)
  end

  def show
    @proverb = Proverb.find_by_id(params[:id])
  end

end
