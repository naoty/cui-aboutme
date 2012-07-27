class UsersController < ApplicationController

  def index
    @users = User.all.asc(:created_at)
  end

  def show
    @user = User.find_by_name(params[:id])
  end

  def item
    user = User.find_by_name(params[:id])
    @item_value = user.read_attribute(params[:item])
    if @item_value
      render status: :ok
    else
      render '404_item', status: :not_found
    end
  end

  def man
    @user = User.find_by_name(params[:id])
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
    @user = User.find_by_name(params[:id])
    if not @user.authenticate(params[:password])
      render 'unauthorized', status: :unauthorized
    elsif @user.update_attributes(params)
      render 'success', status: :ok
    else
      render 'error', status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by_name(params[:id])
    if @user.authenticate(params[:password])
      @user.destroy
      render 'success', status: :ok
    else
      render 'unauthorized', status: :unauthorized
    end
  end

end
