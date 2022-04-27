class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]
  before_action :redirect_if_not_current_user, only: :show

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
      redirect_to user_path(user.id)
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
      render :edit
    end
  end

  def delete
    user = User.find(params[:id])
    user&.destroy
    redirect_to new_session_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_if_logged_in
    redirect_to user_path(current_user) if logged_in?
  end

  def redirect_if_not_current_user
    redirect_to users_path unless current_user.id == params[:id].to_i
  end
end
