class UsersController < ApplicationController

  before_filter :redirect_to_home

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

  def destroy
    @user = User.find(params[:id])
    if @user.authenticate(params[:password])
      @user.destroy
      render 'success', status: :ok
    else
      render 'unauthorized', status: :unauthorized
    end
  end

  private

  def redirect_to_home
    unless request.user_agent =~ /curl/
      redirect_to root_path
    end
  end

end
