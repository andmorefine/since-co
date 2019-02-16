class ProverbController < ApplicationController

  def index
    @m_alphabetals = MAlphabetal.joins(:proverb)
                                .distinct
                                .where("proverbs.delete_flag = false")
                                .order("id")

    @search = Proverb.ransack(params[:q])
    @proverb = @search.result(distinct: true)
  end

  def search
    @search = Proverb.search(search_params)
    @proverb = @search.result(distinct: true)
  end

  def show
    @proverb = Proverb.find_by_id(params[:id])
    @proverb_all = Proverb.all.count
    @proverb_prev = @proverb.id - 1 unless @proverb.id == 1
    @proverb_next = @proverb.id + 1 unless @proverb.id == @proverb_all
  end

  def edit
  end

  private
  def search_params
    params.require(:q).permit!
  end

end

