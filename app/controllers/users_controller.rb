class UsersController < ApplicationController
  protect_from_forgery except: [:create, :destroy]

  def index
  end

  def show
    users = User.where(delete_flag: false)
    render json: users
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
