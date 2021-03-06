# frozen_string_literal: true

class ProverbController < ApplicationController
  before_action :fetch_alphabetal, only: %i[index show]
  PER = 50

  def index
    @proverbs = Proverb.active.image_active.sample(20).shuffle

    @search = Proverb.active.ransack(params[:q])
    @proverb = @search.result(distinct: true).page(params[:page]).per(PER)
  end

  def search
    @search = Proverb.active.ransack(search_params)
    @proverb = @search.result(distinct: true).page(params[:page]).per(PER)
  end

  def show
    @proverb = Proverb.find_by_id(params[:id])
    return redirect_to proverb_index_path if @proverb.nil?

    @source_title = @proverb.proverb_sources.active.first.try(:title)
    @proverb_synonyms = []
    @proverb.proverb_synonyms.active.map do |synonym|
      @proverb_synonyms.push(Proverb.find_by_id(synonym.proverb_synonym_id))
    end
    @others = Proverb.where(alphabetal_id: @proverb.alphabetal_id).where(delete_flag: false)
    @proverb_all = Proverb.all.count
    @proverb_prev = @proverb.id - 1 unless @proverb.id == 1
    @proverb_next = @proverb.id + 1 unless @proverb.id == @proverb_all
  end

  def edit; end

  private

  def search_params
    params.require(:q).permit!
  end

  def fetch_alphabetal
    @m_alphabetals = MAlphabetal.joins(:proverb)
                                .distinct
                                .where('proverbs.delete_flag = false')
                                .order('id')
  end
end
