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
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to user_path(@user.id)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    if user&.destroy
      flash[:notice] = " User \"#{@user.email }\" has been deleted"
      redirect_to new_user_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to user_path(@user.id)
    end
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
