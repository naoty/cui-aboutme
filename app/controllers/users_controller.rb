class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params)
    if @user.save
      render 'success', status: :ok
    else
      render 'error', status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if not @user.authenticate(params[:password])
      render 'unauthorized', status: :unauthorized
    elsif @user.update_attributes(params)
      render 'success', status: :ok
    else
      render 'error', status: :unprocessable_entity
    end
  end
end
