# frozen_string_literal: true

class AlphabetalController < ApplicationController
  def show
    @m_alphabetals = MAlphabetal.joins(:proverb)
                                .distinct
                                .where('proverbs.delete_flag = false')
                                .order('id')
    @alphabetal = MAlphabetal.find(params[:id])
    @alphabetal_all = MAlphabetal.all.size
    @proverbs = Proverb.page.where(alphabetal_id: params[:id]).per(1000)
    @alphabetal_prev = @alphabetal.id - 1 unless @alphabetal.id == 1
    @alphabetal_next = @alphabetal.id + 1 unless @alphabetal.id == @alphabetal_all
  end
end
