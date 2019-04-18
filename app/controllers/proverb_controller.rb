# frozen_string_literal: true

class ProverbController < ApplicationController
  before_action :fetch_alphabetal, only: %i[index show]
  PER = 50

  def index
    # Model.find(Model.pluck(:id).shuffle[0..4])

    @proverbs = Proverb.active.find(Proverb.pluck(:id).sample(11))

    @search = Proverb.active.ransack(params[:q])
    @proverb = @search.result(distinct: true).page(params[:page]).per(PER)
  end

  def search
    @search = Proverb.active.ransack(search_params)
    @proverb = @search.result(distinct: true).page(params[:page]).per(PER)
  end

  def show
    @proverb = Proverb.find_by_id(params[:id])
    @proverb_all = Proverb.all.count
    @proverb_prev = @proverb.id - 1 unless @proverb.id == 1
    @proverb_next = @proverb.id + 1 unless @proverb.id == @proverb_all

    versions = Proverb.find(params[:id]).versions.where(event: :update).sort.reverse
    @versions = []
    versions.each do |version|
      @versions.push(
        id: version.id,
        object_changes: YAML.safe_load(version.object_changes),
        whodunnit: version.whodunnit,
        created_at: version.created_at.strftime('%Y年%m月%d日 %H:%M')
      )
    end
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
