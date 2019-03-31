class ProverbController < ApplicationController
  before_action :fetch_alphabetal, only: [:index, :show]
  PER = 50

  def index
    @proverbs = Proverb.active.order('RAND()').limit(10)

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

    @versions = Proverb.find(params[:id]).versions.sort.reverse
    @version_object = {}
    @versions.map do |version|
      version.object_changes = YAML::load(version.object_changes)
      @version_object.store(version.id, {})
      array = version.object_changes.delete(' ').split(/=>|,/)
      object = {}
      array.each_slice(3).map do |k, v, s|
        k_s = k.delete('{[\"]')
        v_s = v.delete('[\"')
        s_s = s.delete('\"]}')
        object.store(k_s.to_s, [v_s.to_s, s_s.to_s])
      end
      @version_object.store(version.id, object)
    end
  end

  def edit
  end

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
