class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      login_user!(user)
      redirect_to root_path
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)

    if user.save
      redirect_to user_path(user.id)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def delete
    user = User.find(params[:id])
    user&.destroy
    redirect_to users_path
  end
end
