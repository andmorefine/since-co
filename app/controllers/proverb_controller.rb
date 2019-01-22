class ProverbController < ApplicationController

  def index
    @m_alphabetals = MAlphabetal.joins(:proverb)
                                .distinct
                                .where("proverbs.delete_flag = false")
  end

  def show
    @proverb = Proverb.find_by_id(params[:id])
  end

end
