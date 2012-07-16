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
end
