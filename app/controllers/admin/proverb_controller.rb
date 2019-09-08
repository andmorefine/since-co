# frozen_string_literal: true

class Admin::ProverbController < Admin::Base
  before_action :admin_member
  protect_from_forgery except: %i[update create destroy]

  def preview
    @search = Proverb.recent.ransack(params[:q])
    @proverb = @search.result(distinct: true).page(params[:q][:page]).per(params[:q][:limit])
    render json: @proverb
  end

  def fetch
    proverb = Proverb.find_by_id(params[:id])
    proverb_h = proverb.attributes
    proverb_h["synonyms"] = proverb.proverb_synonyms.active
    render json: proverb_h
  end

  def versions
    versions = Proverb.find(params[:id]).versions

    versions.map do |version|
      version.object_changes = YAML.safe_load(version.object_changes).to_json
    end

    render json: versions.sort.reverse
  end

  def alphabetal
    m_alphabetal = MAlphabetal.all
    render json: m_alphabetal
  end

  def index; end

  def show
    gon.id = params[:id]
  end

  def edit
    gon.id = params[:id]
  end

  def destroy
    proverb = Proverb.find(params[:_json])
    proverb.delete_flag = true
    begin
      proverb.save!
    rescue StandardError => e
      p e.message
    end
  end

  def update
    proverb = Proverb.find_by_id(params[:id])
    begin
      proverb.update!(proverb_params)
      params[:synonyms].each do |synonym|
        if synonym[:id].present?
          proverb_synonym = ProverbSynonym.find(synonym[:id])
          proverb_synonym.update!(title: synonym[:title], proverb_synonym_id: synonym[:proverb_synonym_id], delete_flag: synonym[:delete_flag])
        elsif synonym[:proverb_synonym_id] != 0
          ProverbSynonym.create!(title: synonym[:title], proverb_synonym_id: synonym[:proverb_synonym_id], proverb_id: proverb.id,)
        end
      end
    rescue StandardError => e
      p e.message
    end

    render json: proverb
  end

  def create
    Proverb.create!(proverb_params)
  rescue StandardError => e
    p e.message
  end

  def proverb_params
    params.require(:proverb).permit(
      :id,
      :name,
      :kana,
      :text,
      :image,
      :alphabetal_id,
      :delete_flag
    )
  end

  private

  def admin_member
    if current_member
      redirect_to(root_url) unless current_member.admin?
    else
      redirect_to(root_url)
    end
  end
end
