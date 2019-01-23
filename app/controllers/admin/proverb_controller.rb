class Admin::ProverbController < Admin::Base
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
