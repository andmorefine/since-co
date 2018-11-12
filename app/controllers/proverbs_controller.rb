class ProverbsController < ApplicationController

  protect_from_forgery except: [:create, :destroy]

  def index
  end

  def show
  end

  def destroy
    user = User.find(params[:_json])
    user.delete_flag = true
    user.save
  end

  def create
    params[:user]
    user = User.new
    user.attributes = { name: params[:name] }
    user.save
  end

end
