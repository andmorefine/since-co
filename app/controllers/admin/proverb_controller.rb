class Admin::ProverbController < ApplicationController
  before_action :admin_member
  protect_from_forgery except: [:update, :create, :destroy]

  def preview
    proverbs = Proverb.all.order(created_at: :desc)
    render :json => proverbs
  end

  def fetch
    proverb = Proverb.find_by_id(params[:id])
    render :json => proverb
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
    proverb.save
  end

  def update
    proverb = Proverb.find_by_id(params[:id])
    proverb.update(proverb_params)
  end

  def create
    Proverb.create(proverb_params)
  end

  def proverb_params
    params.require(:proverb).permit(
      :id,
      :name,
      :kana,
      :text,
      :image,
      :alphabetal_id,
    )
  end

  private
    def admin_member
      if current_member
        redirect_to(root_url) unless current_member.admin?
        # render :layout => "admin" if current_member.admin?
      else
        redirect_to(root_url)
      end
    end

end
