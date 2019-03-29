class Admin::ProverbController < Admin::Base
  before_action :admin_member
  protect_from_forgery except: [:update, :create, :destroy]

  def preview
    @search = Proverb.recent.ransack(params[:q])
    @proverb = @search.result(distinct: true).page(params[:q][:page]).per(params[:q][:limit])
    render :json => @proverb
  end

  def fetch
    proverb = Proverb.find_by_id(params[:id])
    render :json => proverb
  end

  def versions
    versions = Proverb.find(params[:id]).versions
    render :json => versions
  end

  def alphabetal
    m_alphabetal = MAlphabetal.all
    render :json => m_alphabetal
  end

  def index
  end

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
    rescue => e
      p e.message
    end
  end

  def update
    proverb = Proverb.find_by_id(params[:id])
    begin
      proverb.update!(proverb_params)
    rescue => e
      p e.message
    end
  end

  def create
    begin
      Proverb.create!(proverb_params)
    rescue => e
      p e.message
    end
  end

  def proverb_params
    params.require(:proverb).permit(
      :id,
      :name,
      :kana,
      :text,
      :image,
      :alphabetal_id,
      :delete_flag,
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
